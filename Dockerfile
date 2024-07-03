# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    sudo \
    nodejs \
    npm

# Install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh -O anaconda.sh && \
    bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PATH /opt/conda/bin:$PATH

# Install Python dependencies
COPY ./vash/requirements.txt /vash/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /vash/requirements.txt

# Copy the application code
COPY ./vash /vash

# Replace base.py and settings.py
COPY ./vash/base.py /opt/conda/lib/python3.11/site-packages/django/db/backends/mysql/base.py
COPY ./vash/settings.py /vash/proj/settings.py

# Install npm dependencies and build the project
WORKDIR /vash
RUN npm install
COPY ./vash/semantic.css /vash/node_modules/semantic-ui-offline/semantic.css
RUN npm install
RUN npm run build

# Create necessary directories
RUN mkdir /vash/mysql
RUN mkdir -p /home/user/annovar_files

# Run database migrations
RUN python3 manage.py makemigrations app && \
    python3 manage.py migrate

# Create user
WORKDIR /vash/bin
RUN python3 user.py user P@ssw0rd

# Expose the port the app runs on
EXPOSE 8000

# Start the server
CMD ["npm", "run", "start:server"]
