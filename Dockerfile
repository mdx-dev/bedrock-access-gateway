FROM python:3.12-slim AS bedrock-access-gateway
WORKDIR /app
COPY ./src/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY ./src/api /app/api
CMD ["uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "80"]
