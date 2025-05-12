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

## Create the DB Tables
```
docker exec -i chess-mysql \
  mysql -u chessuser -pchesspass chessdb < ./sql/create_user_tables.sql

```

For Windows, you can use the following command to create the tables:
```
 Get-Content .\sql\ | docker exec -i chessdb_mysql mysql -u chessuser -pchesspass chessdb
```
In Django, iteracting with DB using admin functions (ready()) is not recommended. Instead, we will use the command line to create the tables. [ref](https://stackoverflow.com/questions/57369950/how-to-call-a-function-before-a-django-app-start/57369989#57369989:~:text=AppConfig.ready()%20docs,in%20your%20ready()%20implementation.)



Note that if this does not work do the following:
1. connect to the DB using the following command in terminal:
```
mysql -h 127.0.0.1 -P 3307 -u chessuser -p
```
2. Directly run the SQL commands in the `create_user_tables.sql` file to create the tables.




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