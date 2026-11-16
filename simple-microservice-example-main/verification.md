randerson6@DESKTOP-2N3IPMB:~/Fall2026/CSCI644/simple-microservice-example-main$make test-e2e BASE_URL=http://localhost:8080
python3 tests/e2e.py "http://localhost:8080"
PASS test_frontend
PASS test_status_and_request_id
PASS test_health_and_readiness
PASS test_version_metadata
PASS test_seeded_quote_is_present
PASS test_random_quote_and_counter
PASS test_create_and_read_quote
All contract tests passed for http://localhost:8080
