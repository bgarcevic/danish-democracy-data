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
    source .venv/bin/activate
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract-load\danish_parliament_data_retriever.py
    dbt deps
    dbt build
    dbt docs generate
    dbt docs serve
    ```
* PowerShell:
    ```powershell
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    python -m venv .dbtenv
    .venv\Scripts\Activate.ps1
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract-load\danish_parliament_data_retriever.py
    dbt deps
    dbt build
    dbt docs generate
    dbt docs serve
    ```
* Windows CMD:
    ```
    git clone https://github.com/bgarcevic/danish-democracy-data.git
    cd danish-democracy-data
    python -m venv .dbtenv
    .venv\Scripts\activate.bat
    python -m pip install --upgrade pip
    python -m pip install -r requirements.txt
    python extract-load\danish_parliament_data_retriever.py
    dbt deps
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
├── curated
└── raw
    ├── afstemning
    │   ├── afstemning_yyyymmdd.json
    │   └── last_run_afstemning.json
    ├── afstemningstype
    │   ├── afstemningstype_yyyymmdd.json
    │   └── last_run_afstemningstype.json
    ├── aktør
    │   ├── aktør_yyyymmdd.json
    │   └── last_run_aktør.json
    ├── aktørtype
    │   ├── aktørtype_yyyymmdd.json
    │   └── last_run_aktørtype.json
    ├── møde
    │   ├── møde_yyyymmdd.json
    │   └── last_run_møde.json
    ├── mødestatus
    │   ├── mødestatus_yyyymmdd.json
    │   └── last_run_mødestatus.json
    ├── mødetype
    │   ├── mødetype_yyyymmdd.json
    │   └── last_run_mødetype.json
    ├── periode
    │   ├── periode_yyyymmdd.json
    │   └── last_run_periode.json
    ├── sag
    │   ├── sag_yyyymmdd.json
    │   └── last_run_sag.json
    ├── sagstrin
    │   ├── sagstrin_yyyymmdd.json
    │   └── last_run_sagstrin.json
    ├── sagstrinaktør
    │   ├── sagstrinaktør_yyyymmdd.json
    │   └── last_run_sagstrinaktør.json
    ├── sagstrinsstatus
    │   ├── sagstrinsstatus_yyyymmdd.json
    │   └── last_run_sagstrinsstatus.json
    ├── sagstrinstype
    │   ├── sagstrinstype_yyyymmdd.json
    │   └── last_run_sagstrinstype.json
    ├── stemme
    │   ├── stemme_yyyymmdd.json
    │   └── last_run_stemme.json
    └── stemmetype
        ├── stemmetype_yyyymmdd.json
        └── last_run_stemmetype.json
```

### DuckDB location

DuckDB file will be in project-root under `data/danish_democracy_data.duckdb`

## Staging:

Run 

* PowerShell:
    ```powershell
    python extract-load\danish_parliament_data_retriever.py
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