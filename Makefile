.PHONY: install lint test test-cov clean help

install: ## Install all dependencies
	uv sync --all-groups
	uv run pre-commit install

lint: ## Run linter
	uv run ruff check scholar/ tests/

test: ## Run tests
	uv run pytest

test-cov: ## Run tests with coverage
	uv run pytest --cov=scholar --cov-report=term-missing

clean: ## Clean build artifacts
	rm -rf build/ dist/ .eggs/ *.egg-info/ .pytest_cache/ .ruff_cache/ .coverage htmlcov/
	find . -type d -name __pycache__ -exec rm -rf {} +

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
