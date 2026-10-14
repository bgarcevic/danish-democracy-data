import argparse
import logging

import dlt
from dlt.sources.rest_api import RESTAPIConfig, rest_api_resources

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
                    # "ge" re-fetches rows on the boundary timestamp; dlt
                    # deduplicates them using the primary key
                    "$filter": (
                        "opdateringsdato ge datetime'{incremental.start_value}'"
                    ),
                },
                "incremental": {
                    "cursor_path": "opdateringsdato",
                    "initial_value": "2014-01-01T00:00:00",
                },
                "data_selector": "value",
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


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--limit",
        type=int,
        help="Max pages to fetch per resource (for quick dev runs).",
    )
    parser.add_argument(
        "--pipeline-name",
        default="rest_api_danish_parliament",
        help="Use a different name to keep dev runs out of the main state.",
    )
    args = parser.parse_args()

    pipeline = dlt.pipeline(
        pipeline_name=args.pipeline_name,
        destination=dlt.destinations.duckdb("danish_democracy_data.duckdb"),
        dataset_name="danish_parliament",
    )

    source = danish_parliament_source()
    if args.limit:
        source.add_limit(args.limit)

    load_info = pipeline.run(source)
    # Logging the load information
    logger.info("Pipeline run completed successfully")
    logger.info(load_info)


if __name__ == "__main__":
    main()
