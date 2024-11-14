# Danish Democracy Data

This repo is a personal hobby project using open source alternatives to create a data warehouse for the data of the Danish parliament. 
The API used is the open API from [Folketinget API](https://oda.ft.dk/Home/WebApi) as the primary source of data.

## Development

* Python >= 3.11 https://www.python.org/downloads/

### Running this project

Following commands create and activate a virtual environment and run the project.

* Bash:
    ```bash
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    python -m venv .dbtenv
    source .dbtenv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract/danish_parliament_data_retriever.py
    dbt deps
    dbt seed
    dbt build
    dbt docs generate
    dbt docs serve
    ```
* PowerShell:
    ```powershell
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    python -m venv .dbtenv
    .dbtenv\Scripts\Activate.ps1
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract\danish_parliament_data_retriever.py
    dbt deps
    dbt seed
    dbt build
    dbt docs generate
    dbt docs serve
    ```
* Windows CMD:
    ```
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    python -m venv .dbtenv
    .dbtenv\Scripts\activate.bat
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract\danish_parliament_data_retriever.py
    dbt deps
    dbt seed
    dbt build
    dbt docs generate
    dbt docs serve
    ```

### Development Tools

* Code formatting: `black`
* Add-in: `dbt Power User`
* SQL linting/formatting: `sqlfluff`

## File Locations

The data directory will look like this:
```
data
├── danish_democracy_data.duckdb
└── curated

### DuckDB location

DuckDB file will be in project-root under `data/danish_democracy_data.duckdb`

## Staging:

Run 

* PowerShell:
    ```powershell
    python extract\danish_parliament_pipeline.py
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
