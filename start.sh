#!/bin/bash

set -e

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
