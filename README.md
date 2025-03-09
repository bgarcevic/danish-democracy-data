# Danish Democracy Data

This repo is a personal hobby project using open source alternatives to create a data warehouse for the data of the Danish parliament. 
The API used is the open API from [Folketinget API](https://oda.ft.dk/Home/WebApi) as the primary source of data.

## Development

* Install uv https://docs.astral.sh/uv/getting-started/installation/

Use curl to download the script and execute it with sh:

macOS and Linux:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

windows:
```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### Running this project

Following commands create and activate a virtual environment and run the project.

* Bash:
    ```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    uv run python extract/danish_parliament_data_retriever.py
    cd dbt
    uv run dbt deps
    uv run dbt build
    uv run dbt docs generate
    uv run dbt docs serve
    ```
* PowerShell:
    ```powershell
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    uv run python extract\danish_parliament_data_retriever.py
    cd dbt
    uv run dbt deps
    uv run dbt build
    uv run dbt docs generate
    uv run dbt docs serve
    ```
* Windows CMD:
    ```
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    uv run python extract\danish_parliament_data_retriever.py
    cd dbt
    dbt deps
    dbt seed
    dbt build
    dbt docs generate
    dbt docs serve
    ```

### Development Tools

* Code formatting: `ruff`
* Add-in: `dbt Power User`
* SQL linting/formatting: `sqlfluff`

## File Locations

### DuckDB location

DuckDB file will be in project-root under `danish_democracy_data.duckdb`

## Staging:

Run 

* PowerShell:
    ```powershell
    uv run extract\danish_parliament_pipeline.py
    ```

## dbt

Install dbt_utils:
```
dbt deps
```

Run models:
```
dbt run
```

Run tests:
```
dbt test
```

### sqlfluff

Run SQL linter on dbt models:
```
sqlfluff lint
```

### export the data to parquet

Change the materialization to 'external' in dbt_projects.yml for the mart layer and run dbt build.

Read more [here](https://github.com/duckdb/dbt-duckdb?tab=readme-ov-file#writing-to-external-files).

## Browsing the data
Some options:
- [duckcli](https://pypi.org/project/duckcli/)
- [DuckDB CLI](https://duckdb.org/docs/installation/?environment=cli)
- [How to set up DBeaver SQL IDE for DuckDB](https://duckdb.org/docs/guides/sql_editors/dbeaver)

---
For more information on dbt:
- Read the [introduction to dbt](https://docs.getdbt.com/docs/introduction)
- Read the [dbt viewpoint](https://docs.getdbt.com/docs/about/viewpoint)
- Join the [dbt Community](http://community.getdbt.com/)
