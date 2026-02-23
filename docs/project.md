# Project Documentation

## Overview

Below is an outline of the foundation for the 'Is Bitcoin Digital Gold' project. It follows best practices for organization, reproducibility, and collaborative work.

## Project Structure

```
rg_project/
├── .git/                       # Git Repository
├── .venv/                      # Virtual Python environment
├── .vscode/                    # VS Code configuration
│   ├── extensions.json         # VS Code extensions
│   └── settings.json           # Workspace-specific settings
├── data/                       # Data directory
│   ├── clean/                  # Data processed through cleaning measures
│   ├── etl_scripts/            # Scripts for extracting, cleaning and finalizing data 
│   ├── final/                  # Finalized data ready to be commited to database
│   ├── raw/                    # Raw data extracted from Python Libraries and APIs
│   └── bitcoin_gold_database   # Database housing finalized data                  
├── docs/                       # Project documentation
├── notebooks/                  # Jupyter Notebooks and Python Scripts for data analysis
├── plots/                      # Visualisations
├── src/                        # Python Source Code
├── .gitignore                  # Git Ignore rules
├── .python-version             # Python Version fur uv
├── pyproject.toml              # Project configuration
├── README.md                   # Project description
└── uv.lock                     # Dependencies Lock file
```
