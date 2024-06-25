### Readme 

#### Prerequisites
- Ensure Docker and Docker Compose are installed on your system.
    - Docker
    - Docker Compose
    - Node.js
    - Python 3

#### Setup Steps
1. **Clone the repository:**
    ```sh
    git clone https://github.com/mandy0104/vash.git
    cd vash
    ```

2. **Build and run the Docker containers:**
    ```sh
    docker-compose up --build
    ```

3. **Wait for the services to start:**
    - The web service will be available on `http://localhost:8000`.
    - MySQL database will be running and accessible on port `3306`.

4. **Create and apply database migrations:**
    ```sh
    docker-compose exec web python3 manage.py makemigrations app
    docker-compose exec web python3 manage.py migrate
    ```

5. **Create a user:**
    ```sh
    docker-compose exec web python3 bin/user.py user P@ssw0rd
    ```

6. **Copy necessary VCF files to the required directory:**
    ```sh
    cp [vcf-files] ./home/user/annovar_files/
    ```

7. **Start the server:**
    ```sh
    docker-compose exec web npm run start:server
    ```

#### Notes
- Adjust file paths as necessary based on your local setup.
- Ensure any environment-specific variables are properly configured in the `docker-compose.yml` file.