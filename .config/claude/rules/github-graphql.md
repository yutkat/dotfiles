# GitHub GraphQL API

- GitHub kills GraphQL queries that run ~10s server-side and returns HTTP 502 (nginx HTML, not JSON); a consistent 502 on one query means the query is too expensive, not a transient outage
- Node/point limits passing does NOT mean the time limit passes; connection fields differ hugely in resolver cost (measured: `UserList.items(first:100)` ≈ 1.7-4.2s per list; `Repository.repositoryTopics` for 100 repos ≈ 3s total)
- Before batching multiple connections into one request (aliases or `nodes(ids:)`), measure a single instance's latency with `gh api graphql` against real data; batch only when N × single-cost stays well under 10s
- Retry with backoff only helps transient 5xx; it cannot fix an over-budget query — reduce per-request work instead
- GitHub Lists mutations (`createUserList`, `updateUserListsForItem`) return FORBIDDEN "Resource not accessible by personal access token" for fine-grained PATs even with Starring: Read and write (verified empirically 2026-09); use a classic PAT (`user` scope) for Lists writes — reads work with fine-grained
- Org fine-grained-PAT policies (e.g. max token lifetime) apply to org members' tokens even for reading the org's public repos; the affected nodes come back null with node-level FORBIDDEN errors alongside usable partial data
