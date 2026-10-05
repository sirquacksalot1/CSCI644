FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:latest
RUN apt update
RUN apt install -y python3-full wget
RUN mkdir /app
WORKDIR /app
COPY requirements.txt /tmp/requirements.txt
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install -r /tmp/requirements.txt
