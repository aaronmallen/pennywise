# Development

Ready to build the future of self-hosted finance? This guide will get you up and running with Pennywise development.

## Prerequisites

The essentials for financial freedom:

- [Ruby](https://www.ruby-lang.org) - Programming language
- [NodeJS](https://nodejs.org) - Asset compilation
- [Docker](https://docs.docker.com) - Development service infrastructure
- [Mise](https://mise.jdx.dev) - Version management and task runner

## Technology Stack

We chose tools that respect both developers and users:

- **Backend**: Ruby with Hanami 2.2 framework (elegant, maintainable, and battle-tested)
- **Database**: PostgreSQL (because your data deserves a real database)
- **Frontend**: Server-rendered HTML with Tailwind CSS v4 and DaisyUI components (fast, accessible, and beautiful)
- **Infrastructure**: Docker for development (consistency without complexity)

## Quick Start

```shell
# Install dependencies and setup the project (your financial future starts here)
mise dev:setup

# Start the development environment (watch the magic happen)
mise dev
```

The application will be available at `http://localhost:2300` - your personal finance command center.

## Project Structure

Organized like your budget should be:

```tree
├── app/
│   ├── assets/          # CSS, JS, and images
│   ├── templates/       # ERB templates and layouts
│   └── views/           # View classes and helpers
├── lib/
│   └── pennywise/       # Core business logic (where the magic happens)
├── config/
│   ├── db/              # Database migrations and seeds
│   └── providers/       # Application providers
├── spec/                # Test suite (because bugs cost money)
├── bin/                 # Development scripts
└── mise.toml            # Version and task configuration
```

## Available Commands

Your toolkit for building financial independence:

```shell
# Environment management
mise dev:setup      # Configure development environment (run after git pull - maintenance matters)
mise dev            # Launch development environment (your workspace awaits)

# Testing and quality
mise test           # Execute test suite (trust, but verify)
mise lint           # Analyze code style (clean code, clean finances)
mise lint:fix       # Analyze and auto-correct code style (automated excellence)

# Database management
mise db:migrate     # Apply database migrations (evolve your data structure)
mise db:prepare     # Initialize database (lay the foundation)
mise db:seed        # Populate database with sample data (see what's possible)

# Code generators
mise g:action       # Create a Hanami action (build your features)
mise g:migration    # Create a Hanami migration (structure your changes)
mise g:relation     # Create a Hanami relation (model your reality)
mise g:repo         # Create a Hanami repository (manage your data)
```

> [!TIP]
> `mise dev:setup` is idempotent and should be run after every `git pull` - because consistency builds confidence
