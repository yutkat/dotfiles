# CLAUDE.md

This file provides general guidance to Claude Code (claude.ai/code) when
working with code across all projects.

## Development Guidelines

### Test-Driven Development

- Write tests before implementing functionality
- Follow red-green-refactor cycle (Red: write failing test, Green: make it
  pass, Refactor: improve code quality)
- Ensure comprehensive test coverage for all new features
- Run all tests before committing changes
- Use appropriate testing frameworks for each language
- Mock external dependencies and API calls in tests

### Code Quality Standards

- **Language**: Write all code comments and documentation in English
- **Comments**: Avoid excessive comments; write self-documenting code with
  clear variable and function names
- **Formatting**: Always apply formatters and linters before committing
- **Functions**: Keep functions small and follow single responsibility
  principle (max 20-30 lines when possible)
- **Testing**: Always verify functionality works correctly before committing
- **Security**: Never hardcode passwords, API keys, or sensitive data in
  source code
- **Performance**: Consider performance implications and optimize when needed
- **Error Handling**: Implement proper error handling and graceful degradation
- **Documentation**: Keep README files and inline documentation up to date

### Version Control Best Practices

- Write clear, descriptive commit messages
- Make atomic commits (one logical change per commit)
- Use conventional commit format when applicable
- Review changes before committing
- Never commit generated files or build artifacts
- Use .gitignore to exclude temporary and sensitive files
- Use conventional commit format

### Performance Optimization

- Profile code before optimizing
- Use appropriate data structures and algorithms
- Cache expensive computations when possible
- Minimize I/O operations
- Use lazy loading for large datasets
- Monitor resource usage in production

### Security Considerations

- Use secrets management tools (never commit secrets)
- Validate all inputs and sanitize outputs
- Apply principle of least privilege
- Keep dependencies up to date
- Use HTTPS for all external communications
- Implement proper authentication and authorization
- Regularly audit dependencies for vulnerabilities

### Code Review Guidelines

- Review for correctness, readability, and maintainability
- Check for security vulnerabilities
- Ensure proper error handling
- Verify test coverage
- Look for performance issues
- Confirm documentation is updated

### Pre-commit Checklist

- Run all tests and ensure they pass
- Apply formatters and linters
- Verify functionality works as expected
- Check for hardcoded secrets or credentials
- Review code changes for potential issues
- Update documentation if needed
- Ensure commit messages are clear and descriptive
- Validate that builds complete successfully

## Language specific

### Shell Scripts

- Start with shebang: `#!/usr/bin/env bash`
- Use strict mode: `set -ue` or `set -Eeuo pipefail`
- Function syntax: `function name() {}`
- Variables: snake_case, always quoted `"${variable}"`
- Error handling: Use traps for cleanup
- Prefer local variables with `local` keyword
- Handle errors with informative messages
- Use shellcheck for linting shell scripts

### JavaScript/TypeScript

- Use ESLint and Prettier for code quality and formatting
- Prefer const/let over var
- Use TypeScript for type safety when possible
- Handle promises properly with async/await
- Write unit tests with Jest or similar frameworks
- Follow airbnb style guide or similar established conventions

### Python

- Follow PEP 8 style guidelines
- Use type hints for function parameters and return values
- Use virtual environments for dependency management
- Write docstrings for functions and classes
- Use pytest for testing
- Apply black for code formatting
- Use mypy for static type checking

### Rust

- Use cargo fmt for formatting and cargo clippy for linting
- Handle errors with Result types, avoid unwrap() in production
- Use meaningful variable and function names
- Write unit tests and integration tests
- Follow Rust naming conventions
- Use cargo check for fast compilation checks
