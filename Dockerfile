FROM python:3.14-slim AS base

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app
COPY pyproject.toml uv.lock ./

# Training image
FROM base AS training
RUN uv sync --frozen --group ml --no-dev --no-install-project
COPY scholar/ scholar/
ENTRYPOINT ["echo", "success"]

# App image
FROM base AS app
RUN uv sync --frozen --group app --no-dev --no-install-project
COPY scholar/ scholar/
ENTRYPOINT ["echo", "success"]
