import dlt
from dlt.sources.rest_api import RESTAPIConfig, rest_api_resources
import logging

# Configure the logger for dlt
# Create a logger and set handler
logger = logging.getLogger("dlt")
logger.setLevel(logging.INFO)


@dlt.source
def danish_parliament_source():
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
                "next_url_path": "['odata.nextLink']",
            },
        },
        "resource_defaults": {
            "write_disposition": "merge",
            "parallelized": True,
            "primary_key": "id",
            "endpoint": {
                "params": {
                    "$inlinecount": "allpages",
                    "$filter": {
                        "type": "incremental",
                        "cursor_path": "opdateringsdato",
                        "initial_value": "2014-01-01T00:00:00",
                        "convert": lambda epoch: "opdateringsdato gt datetime'" + epoch + "'",
                    },
                },
                "data_selector": "value",
            },
        },
        "resources": [
            # "Afstemning",
            # "Afstemningstype",
            # "Aktør",
            # "Aktørtype",
            # "Møde",
            # "Mødestatus",
            # "Mødetype",
            # "Periode",
            # "Sag",
            # "Sagstrin",
            # "SagstrinAktør",
            # "Sagstrinsstatus",
            # "Sagstrinstype",
            # "Sagskategori",
            # "Sagsstatus",
            # "Sagstype",
            # "Stemme",
            "Stemmetype",
        ],
    }

    yield from rest_api_resources(config)


def load_danish_parliament() -> None:
    pipeline = dlt.pipeline(
        pipeline_name="rest_api_danish_parliament",
        destination=dlt.destinations.duckdb("danish_democracy_data.duckdb"),
        dataset_name="danish_parliament",
    )

    pipeline.run(danish_parliament_source())
    # Logging the load information
    logger.info("Pipeline run completed successfully")
    logger.info(f"Last Trace: {pipeline.last_trace}")


if __name__ == "__main__":
    load_danish_parliament()
