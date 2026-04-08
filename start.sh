#!/bin/bash

set -e

# Check Python3 is installed
if ! command -v python3 &>/dev/null; then
  echo ">>> Python3 is not installed. Please install Python 3.10+ from https://www.python.org/downloads/"
  exit 1
fi

# Check Python version >= 3.10
PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")

if python3 -c "import sys; exit(0 if sys.version_info >= (3, 10) else 1)"; then
  echo ">>> Python $PYTHON_VERSION found."
else
  echo ">>> Python $PYTHON_VERSION is too old. Please install Python 3.10 or higher."
  echo ">>> Download from: https://www.python.org/downloads/"
  exit 1
fi

echo ">>> Making virtual env..."
python3 -m venv env

echo ">>> Activating virtual environment..."
source env/bin/activate

# Install dependencies if needed
if ! python -c "import django" 2>/dev/null; then
  echo ">>> Installing dependencies..."
  pip install -r requirements.txt
fi

# Copy .env if it doesn't exist
if [ ! -f .env ]; then
  echo ">>> .env not found. Copying from .env.example..."
  cp .env.example .env
  echo ">>> Please update .env with your actual values, then re-run this script."
  exit 1
fi

echo ">>> Running migrations..."
python manage.py migrate

echo ">>> Starting development server..."
python manage.py runserver
