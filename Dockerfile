FROM python:3.9-slim

WORKDIR /myapp

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ARG port=80
ENV STREAMLIT_SERVER_PORT ${port}
EXPOSE ${port}

HEALTHCHECK CMD curl --fail http://localhost:${STREAMLIT_SERVER_PORT}/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.address=0.0.0.0"]
