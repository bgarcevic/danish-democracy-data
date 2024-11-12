import dlt
from dlt.sources.rest_api import RESTAPIConfig, rest_api_resources, DltResource
import logging
import sys
from loguru import logger

class InterceptHandler(logging.Handler):

    @logger.catch(default=True, onerror=lambda _: sys.exit(1))
    def emit(self, record):
        # Get corresponding Loguru level if it exists.
        try:
            level = logger.level(record.levelname).name
        except ValueError:
            level = record.levelno

        # Find caller from where originated the logged message.
        frame, depth = sys._getframe(6), 6
        while frame and frame.f_code.co_filename == logging.__file__:
            frame = frame.f_back
            depth += 1

        logger.opt(depth=depth, exception=record.exc_info).log(level, record.getMessage())

logger_dlt = logging.getLogger("dlt")
logger_dlt.addHandler(InterceptHandler())

logger.add("dlt_loguru.log")

@dlt.source
def folketinget_source():
    """
    This function sets up a REST API configuration to fetch data from the 
    Folketinget API. 
    Yields:
        Generator: A generator that yields resources fetched from the REST API.
    """
    config: RESTAPIConfig = {
        "client": {
            "base_url": "https://oda.ft.dk/api/",
            "paginator": {
                "type": "json_link",
                "next_url_path": "odata.nextLink",
            },
        },
        "resource_defaults": {
            "write_disposition": "replace",
            "parallelized": True,
            "endpoint": {
                "params": {
                    "inlinecount": "allpages",
                },
             },
        },
        "resources": [
            "Afstemning",
            "Afstemningstype",
            "Aktør",
            "Aktørtype",
            "Møde",
            "Mødestatus",
            "Mødetype",
            "Periode",
            "Sag",
            "Sagstrin",
            "SagstrinAktør",
            "Sagstrinsstatus",
            "Sagstrinstype",
            "Sagskategori",
            "Sagsstatus",
            "Sagstype",
            "Stemme",
            "Stemmetype",
        ],
    }

    yield from rest_api_resources(config)


def load_energi_data_service() -> None:
    pipeline = dlt.pipeline(
        pipeline_name="rest_api_energi_data_service",
        destination="duckdb",
        dataset_name="folketinget"
    )

    load_info = pipeline.run(folketinget_source())
    # Logging the load information
    logger.info("Pipeline run completed successfully.")
    logger.info(f"Load Info: {load_info}")
    logger.info(f"Started At: {load_info.started_at}")
    logger.info(f"Load Packages: {load_info.load_packages}")
    if load_info.load_packages:
        first_package = load_info.load_packages[0]
        logger.info(f"First Load Package: {first_package}")
        if (
            "completed_jobs" in first_package.jobs
            and first_package.jobs["completed_jobs"]
        ):
            logger.info(
                f"First Completed Job: {first_package.jobs['completed_jobs'][0]}"
            )
    logger.debug(f"Last Trace: {pipeline.last_trace}")


if __name__ == "__main__":
    load_energi_data_service()
         