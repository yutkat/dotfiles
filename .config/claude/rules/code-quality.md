# Code Quality Standards

- **Language**: Write all code comments and documentation in English
- **Comments**: Write a comment only when the code cannot express a non-obvious constraint (ordering requirements, external tool quirks, workarounds); keep it to one short line
- **Comments (forbidden)**: Never narrate history or rationale ("X was needed because we removed Y"), restate what the code does, or reference the conversation/investigation that produced the change; that context belongs in commit messages
- **Formatting**: Always apply formatters and linters
- **Functions**: Keep functions small and follow single responsibility principle (max 20-30 lines when possible)
- **Testing**: Always verify functionality works correctly
- **Security**: Never hardcode passwords, API keys, or sensitive data in source code
- **Error Handling**: Implement proper error handling and graceful degradation
- **Documentation**: Keep README files and inline documentation up to date
- **README**: Never add a License section to a README; the LICENSE file is the single source of truth and a README section is redundant
- **Removal sweeps**: When removing a module, option, or feature, grep for every name it exposes (option/config namespaces like `config.foo.bar`, env vars, CLI flags), not just the package or input name; consumers often reference the option path without naming the module
- **Move/rename sweeps**: After moving or renaming a file/directory, grep the ENTIRE repo (including hidden dirs) for the old path, not just the dirs you expect to reference it; then check for dangling symlinks (`git ls-files -s | grep ^120000` for tracked links, `find . -xtype l` for broken ones) — symlinks don't show up in content grep

## Performance

- Profile code before optimizing
- Use appropriate data structures and algorithms
- Cache expensive computations when possible
- Minimize I/O operations
- Use lazy loading for large datasets

## Code Review

- Review for correctness, readability, and maintainability
- Check for security vulnerabilities
- Ensure proper error handling
- Verify test coverage
- Look for performance issues
- Confirm documentation is updated
