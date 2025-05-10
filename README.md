## 🔧 1. Clone the Repository

```bash
git clone https://github.com/your-username/chessdb.git
cd chessdb
```

## Set up virtual environment

#### Windows
```bash
python -m venv venv
venv\Scripts\activate
```

#### macOS/Linux
```bash
python3 -m venv venv
source venv/bin/activate
```

## Install Dependencies

```bash
pip install -r requirements.txt
```
## Run the Database using Docker

```bash
docker-compose up -d
```

This spins up a MySQL 8.0 server at:

Host: 127.0.0.1

Port: 3307

DB: chessdb

User: chessuser

Password: chesspass

## Run the Application In Venv Terminal

```bash
python manage.py runserver
```

Now you can access the application at `http://127.0.0.1:8000/`

Also you can test DB connection using the following command:

```bash
mysql -h 127.0.0.1 -P 3307 -u chessuser -p
```

Enter the password `chesspass` when prompted.