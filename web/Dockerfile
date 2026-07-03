FROM python:3.14-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

WORKDIR /app

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY app.py db.py ./
COPY templates ./templates

EXPOSE 8080

CMD ["uv", "run", "--no-dev", "gunicorn", "-b", "0.0.0.0:8080", "app:app"]
