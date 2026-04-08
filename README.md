# Healthcare Backend API

A Django REST API for managing patients, doctors, and their mappings with JWT authentication, backed by PostgreSQL (Neon).

---

## Prerequisites

Make sure you have the following installed:
- Python 3.10+
- pip
- Git

---

## Steps to Run Locally

### 1. Clone the repository
```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. Create and activate virtual environment
```bash
python -m venv env
source env/bin/activate
```
> On Windows: `env\Scripts\activate`

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Set up environment variables
```bash
cp .env.example .env
```
Open `.env` and fill in your values:
```
SECRET_KEY=your-secret-key-change-in-production
DEBUG=True
DATABASE_URL=postgresql://<user>:<password>@<host>/<dbname>?sslmode=require
```
> If using Neon, paste your full connection string as `DATABASE_URL`.

### 5. Run migrations
```bash
python manage.py migrate
```

### 6. Start the development server
```bash
python manage.py runserver
```

Server runs at: `http://127.0.0.1:8000/`

---

## API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/register/` | Register a new user |
| POST | `/api/auth/login/` | Login and get JWT tokens |

### Patients (Authenticated)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/patients/` | Create a patient |
| GET | `/api/patients/` | List all patients (by logged-in user) |
| GET | `/api/patients/<id>/` | Get patient details |
| PUT | `/api/patients/<id>/` | Update patient |
| DELETE | `/api/patients/<id>/` | Delete patient |

### Doctors (Authenticated)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/doctors/` | Create a doctor |
| GET | `/api/doctors/` | List all doctors |
| GET | `/api/doctors/<id>/` | Get doctor details |
| PUT | `/api/doctors/<id>/` | Update doctor |
| DELETE | `/api/doctors/<id>/` | Delete doctor |

### Patient-Doctor Mappings (Authenticated)
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/mappings/` | Assign a doctor to a patient |
| GET | `/api/mappings/` | List all mappings |
| GET | `/api/mappings/<patient_id>/` | Get all doctors for a patient |
| DELETE | `/api/mappings/<id>/delete/` | Remove a mapping |

---

## Testing with Postman

### Step 1 — Register
```
POST http://127.0.0.1:8000/api/auth/register/
```
```json
{
  "username": "john",
  "email": "john@example.com",
  "password": "pass123"
}
```

### Step 2 — Login
```
POST http://127.0.0.1:8000/api/auth/login/
```
```json
{
  "username": "john",
  "password": "pass123"
}
```
Copy the `access` token from the response.

### Step 3 — Add Authorization header
For all protected endpoints, add this header in Postman:
```
Authorization: Bearer <your_access_token>
```

### Step 4 — Create a Doctor
```
POST http://127.0.0.1:8000/api/doctors/
```
```json
{
  "name": "Dr. Bob",
  "specialization": "Cardiology",
  "contact": "1234567890",
  "email": "drbob@example.com"
}
```

### Step 5 — Create a Patient
```
POST http://127.0.0.1:8000/api/patients/
```
```json
{
  "name": "Alice Smith",
  "age": 30,
  "gender": "Female",
  "contact": "9876543210",
  "medical_history": "Diabetes"
}
```

### Step 6 — Assign Doctor to Patient
```
POST http://127.0.0.1:8000/api/mappings/
```
```json
{
  "patient": 1,
  "doctor": 1
}
```

### Step 7 — Get Doctors for a Patient
```
GET http://127.0.0.1:8000/api/mappings/1/
```

---

## Project Structure

```
.
├── env/                  # virtual environment
├── healthcare/           # Django project settings
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── api/                  # main app
│   ├── models.py         # Patient, Doctor, PatientDoctorMapping
│   ├── serializers.py
│   ├── views.py
│   ├── urls.py
│   └── migrations/
├── .env                  # local environment variables (not committed)
├── .env.example          # template for environment variables
├── requirements.txt
└── manage.py
```
