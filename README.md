# 🐳 WordPress Infrastructure with Docker Compose

This project sets up a full-featured WordPress application infrastructure using Docker Compose. It includes load balancing, database replication, and SQL query routing using industry-standard components.

---

## 📆 Architecture Overview

```
Browser ⇄ NGINX (Reverse Proxy + Load Balancer) ⇄ WordPress (x2 replicas) ⇄ ProxySQL ⇄ Percona MySQL (Master ⇄ Slave)
```

### 🔧 Components

- **NGINX** – Reverse proxy and load balancer, serves HTTP on `localhost:8080`
- **WordPress** – Blog/CMS application, running in 2 replicated containers
- **Percona MySQL** – MySQL-compatible server with master-slave replication
- **ProxySQL** – SQL-aware load balancer that routes reads to slaves and writes to the master
- **Docker Compose** – Infrastructure orchestration
- **Health Checks** – Active checks on WordPress and database availability

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/wordpress-infra.git
cd wordpress-infra
```

### 2. Copy and configure environment variables

```bash
cp .env.example .env
# Edit .env to configure database name, users, passwords
```

### 3. Start the infrastructure

```bash
docker compose up -d --build
```

### 4. Access your WordPress blog

```http
http://localhost:8080
```

---

## 🛠️ Features

- ✅ WordPress served by multiple containers
- ✅ Load-balanced HTTP traffic via NGINX
- ✅ Percona MySQL master-slave replication
- ✅ SQL load balancing with ProxySQL
- ✅ Data persistence using Docker volumes
- ✅ Health checks for all critical containers

---

## 🗂️ Folder Structure

```
wordpress-infra/
├── docker-compose.yml
├── .env.example
├── README.md
├── nginx/
│   └── nginx.conf
├── wordpress/
│   └── wp-config.php
├── db_conf/
│   ├── master/
│   │   ├── init.sql
│   │   └── master_config.cnf
│   └── slave/
│       ├── init.sql
│       ├── setup_replication.sh
│       └── slave_config.cnf
├── proxysql/
│   └── proxysql.cnf
└── volumes/
    └── (auto-managed by Docker)
```

---

## 🧪 Testing

### Check app health:

```bash
docker ps
docker inspect --format='{{json .State.Health}}' <container_id>
```

### Check DB replication:

1. Insert on master:
```sql
INSERT INTO wp_options (option_name, option_value) VALUES ('replication_test', 'value');
```

2. Query on slave:
```sql
SELECT * FROM wp_options WHERE option_name='replication_test';
```

---

## 🔐 Security Notes

- Keep `.env` out of version control — use `.env.example` instead
- Use secure `MYSQL_ROOT_PASSWORD` and limit public port exposure in production
- SSL termination can be added easily in `nginx.conf`

---

## 📌 Requirements

- Docker
- Docker Compose

---

## 📚 Resources

- [Docker Compose Docs](https://docs.docker.com/compose/)
- [WordPress Config Reference](https://wordpress.org/support/article/editing-wp-config-php/)
- [Percona Replication Guide](https://www.percona.com/doc/)
- [ProxySQL Documentation](https://proxysql.com/documentation/)

---

## 👤 Author

**pr0x1mo**  
[GitHub](https://github.com/mudonja) | [LinkedIn](https://www.linkedin.com/in/velko-bozic-725822131/)

---

## ☁️ Deploy Ideas (Future Work)

- SSL/TLS termination with Certbot
- Move to Kubernetes with Helm charts
- CI/CD deployment via GitHub Actions

