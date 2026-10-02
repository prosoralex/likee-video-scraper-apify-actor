#!/usr/bin/env bash
# Run the "Likee Scraper - Video & Profile Data" Apify Actor synchronously and print the dataset items.
# Usage: export APIFY_TOKEN=your_apify_token && ./run.sh
set -euo pipefail
: "${APIFY_TOKEN:?Set APIFY_TOKEN first (Apify Console > Settings > API & Integrations)}"

curl -sS -X POST "https://api.apify.com/v2/acts/leadsbrary~likee-video-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer ${APIFY_TOKEN}" \
  -H "Content-Type: application/json" \
  -d @- <<'JSON'
{
  "startUrls": [
    {
      "url": "https://likee.video/@Likee_Russia"
    }
  ],
  "usernames": [],
  "hashtags": [],
  "resultType": "videos",
  "maxResults": 3,
  "maxVideosPerInput": 10,
  "includeVideoUrls": true,
  "proxyConfiguration": {
    "useApifyProxy": true
  }
}
JSON
