FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:latest
RUN apt update
RUN apt install -y python3-full wget
RUN mkdir /app
COPY requirements.txt /app
WORKDIR /app
RUN python3 -m venv venv
ENV PATH="venv/bin:$PATH"
RUN pip3 install -r requirements.txt