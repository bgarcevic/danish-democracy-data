# Danish Democracy Data

This repo is a personal hobby project using open source alternatives to create a data warehouse for the data of the Danish parliament.
The API used is the open API from [Folketinget API](https://oda.ft.dk/Home/WebApi) as the primary source of data.

Stack: [dlt](https://dlthub.com/) for extraction, [DuckDB](https://duckdb.org/) as the warehouse and [dbt v2](https://docs.getdbt.com/) for transformations.

## Setup

Install [uv](https://docs.astral.sh/uv/getting-started/installation/):

* macOS / Linux:
    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    ```
* Windows:
    ```powershell
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    ```

Clone the repo and install dependencies:

```bash
git clone https://github.com/bgarcevic/danish-democracy-data.git
cd danish-democracy-data
uv sync
```

## Running the project

1. Extract data from the API into DuckDB (run from the project root):
    ```bash
    uv run python extract/danish_parliament_pipeline.py
    ```
    The pipeline loads incrementally, so later runs only fetch updated records.
    The first full load takes a long time (millions of individual votes). For a quick
    development run, limit the number of pages per resource and use a separate pipeline
    name so the incremental state of the main pipeline is not affected:
    ```bash
    uv run python extract/danish_parliament_pipeline.py --limit 30 --pipeline-name danish_parliament_dev
    ```

2. Build the dbt models (run from `dbt/`):
    ```bash
    cd dbt
    uv run dbt deps
    uv run dbt build
    ```

3. Browse the docs:
    ```bash
    uv run dbt docs generate
    uv run dbt docs serve
    ```

The DuckDB file is created in the project root as `danish_democracy_data.duckdb`.

## Development tools

* Python formatting/linting: `uv run ruff check` and `uv run ruff format`
* SQL linting (run from `dbt/`): `uv run dbt lint` (add `--fix` to apply fixes). Rules are configured in `dbt/.sqlfluff`.
* SQL formatting (run from `dbt/`): `uv run dbt format`
* Editor add-in: [dbt VS Code extension](https://docs.getdbt.com/docs/about-dbt-extension)

## Export the data to parquet

Change the materialization to `external` in `dbt_project.yml` for the mart layer and run `dbt build`.

Read more [here](https://github.com/duckdb/dbt-duckdb?tab=readme-ov-file#writing-to-external-files).

## Browsing the data

Some options:
- [DuckDB CLI](https://duckdb.org/docs/installation/?environment=cli) / DuckDB UI (`duckdb -ui`)
- [How to set up DBeaver SQL IDE for DuckDB](https://duckdb.org/docs/guides/sql_editors/dbeaver)
