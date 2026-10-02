# Likee Scraper - Video & Profile Data — Apify Actor usage guide

[![Run on Apify](https://img.shields.io/badge/Apify-Run%20this%20Actor-24C1E0)](https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara)
[![Try Apify free](https://img.shields.io/badge/Apify-Try%20it%20free-24C1E0)](https://console.apify.com/sign-up?fpr=aupara)

Likee scraper for public videos and creator profiles: views, likes, comments, shares, captions, music and follower counts. Input profile URLs or usernames. Export JSON, CSV or Excel from $1/1,000 results.

> **This repository does not contain the Actor's source code.** The Actor is closed-source and
> runs on Apify's infrastructure. This repo is documentation plus ready-to-run client examples
> (curl, Python, JavaScript) that call the hosted Actor with **your own** Apify API token.

**Run it on Apify →** [https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara](https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara)

## What it does

Likee scraper for public videos and creator profiles: views, likes, comments, shares, captions, music and follower counts. Input profile URLs or usernames. Export JSON, CSV or Excel from $1/1,000 results.

## Use cases

- Export all public videos of a list of Likee creators with views, likes, comments and shares for influencer vetting.
- Track engagement of a creator's recent videos over time by re-running the Actor on a schedule.
- Spot trending sounds, captions and formats by exporting the latest videos of a watchlist of creators.
- Build a creator shortlist with follower counts, bio, country and profile links for outreach.
- Feed Likee metrics into BI tools via the Apify dataset API in JSON, CSV or Excel.


## Input

| Field | Type | Required | Description |
|---|---|---|---|
| `startUrls` | array | no | Likee profile URLs, e.g. https://likee.video/@. Video share links (likee.video/v/) are not supported yet and produce an error row. |
| `usernames` | array | no | Likee usernames/handles without the @ — a convenience alternative to startUrls. |
| `hashtags` | array | no | Reserved for future support. Likee's hashtag/topic endpoints are currently broken on Likee's side, so any hashtag here produces a HASHTAG_UNSUPPORTED error row and is never billed. |
| `resultType` | string | no | What to emit per input: one row per video, one row per creator profile, or both. |
| `maxResults` | integer | yes | Hard cap on billed results for the whole run; protects your spending. |
| `maxVideosPerInput` | integer | no | Maximum videos collected per profile before moving to the next input. |
| `includeVideoUrls` | boolean | no | Include the media URLs Likee publishes (time-limited CDN links). Cover images are returned; direct MP4 links are not available today — Likee's media endpoint refuses every video we tested, so videoFileUrl stays null. |
| `proxyConfiguration` | object | no | Apify datacenter proxy is the default and proven sufficient for this target. |

The full input form (with defaults and validation) is on the [Actor page](https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara).


## Output (sample item)

Sample trimmed for readability (long texts and lists are shortened) — a real run returns the complete data.

```json
{
  "videoId": "7692116355021042996",
  "videoUrl": "https://likee.video/@Likee_Russia/video/7692116355021042996",
  "shareUrl": null,
  "caption": "Различие шаурмы за 100 и за 1000? 🌯 @Danya Bran 💥",
  "hashtags": [],
  "playCount": 15655,
  "likeCount": 437,
  "commentCount": 36,
  "shareCount": 15,
  "postedAt": "2026-10-02T17:00:02.000Z",
  "musicTitle": "Likee Russia",
  "coverImageUrl": "https://video.like.video/eu_live/9u1/01wySW3qmPVN_4.jpg?wmk_sdk=1",
  "videoFileUrl": null,
  "authorUsername": "Likee_Russia",
  "authorNickname": "Likee Russia",
  "authorId": "30004",
  "authorProfileUrl": "https://likee.video/@Likee_Russia",
  "authorFollowerCount": 109078098,
  "authorFollowingCount": 3539,
  "authorTotalLikes": 82058322,
  "authorBio": null,
  "authorCountry": "RU",
  "authorAvatarUrl": "https://img.like.video/asia_live/4hb/0tQMTk_4.png?type=20&auth-token=Ca2w5E4cPM0s-eOKC07FYSispT3umDDtA4Ml6u1FFbM:eyJleHBpcmUiOjE3OTExNTQ1MjMsImFwcGlkIjo0OCwic2VydmljZS1uYW1lIjoibGlrZWUtYWN0aXZpdHktZmxvdy1taWNybyJ9",
  "sourceInput": "https://likee.video/@Likee_Russia",
  "sourceType": "video",
  "scrapedAt": "2026-10-02T22:58:50.882Z",
  "error": null
}
```

## Pricing

Pay only for results: about **$1.50 per 1,000 results** on the Apify Free plan, down to **$1.00 per 1,000** on paid Apify plans.

Apify platform usage (compute) is billed by Apify on top of the per-result price — about **$0.01 per 1,000 results** in our measured test runs (estimate, varies with input). Tip: keep only the output formats and options you need to reduce it.

Prices can change — the [Actor page](https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara) always shows the current pricing.

## Quick start

You need an Apify account and an API token (Apify Console → **Settings → API & Integrations**).
Never commit your token: export it as the `APIFY_TOKEN` environment variable.

### cURL

```bash
curl -X POST "https://api.apify.com/v2/acts/leadsbrary~likee-video-scraper/run-sync-get-dataset-items" \
  -H "Authorization: Bearer $APIFY_TOKEN" \
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
```

### Python (`apify-client`)

```python
import os
from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

run_input = {
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
    "includeVideoUrls": True,
    "proxyConfiguration": {
        "useApifyProxy": True
    }
}

run = client.actor("leadsbrary/likee-video-scraper").call(run_input=run_input)
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item)
```

### JavaScript (`apify-client`)

```javascript
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

const runInput = {
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
};

const run = await client.actor('leadsbrary/likee-video-scraper').call(runInput);
const { items } = await client.dataset(run.defaultDatasetId).listItems();
console.log(items);
```

Runnable versions live in [`examples/`](./examples).

## Troubleshooting

- **401 / "User was not found or authentication token is not valid"** — check that `APIFY_TOKEN` is set and copied completely.
- **The run finished but the dataset is empty** — widen your search input or check the run log on the Apify Console.
- **Run stops early** — you may have reached the maximum cost per run you set in Apify; raise it in the run options.
- **Need something else?** Open an issue in this repository or use the Issues tab on the Actor page.

## Don't have an Apify account yet?

[Sign up here](https://console.apify.com/sign-up?fpr=aupara) — new accounts get $5 of free platform usage every month, enough to try most Actors without paying upfront.
Browse the full [Apify Store](https://apify.com/store?fpr=aupara) or [all Actors from this developer](https://apify.com/leadsbrary?fpr=aupara).

## Links

- Actor page: [https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara](https://apify.com/leadsbrary/likee-video-scraper?fpr=aupara)
- All Actors from this developer: [https://apify.com/leadsbrary?fpr=aupara](https://apify.com/leadsbrary?fpr=aupara)
- Apify API reference: [https://docs.apify.com/api/v2](https://docs.apify.com/api/v2)

## Keywords

likee scraper, likee video scraper, likee profile scraper, likee api, likee data export, likee creator analytics, scrape likee.video, likee video metadata, likee follower count export, likee trending videos

#likee #likeescraper #webscraping #socialmedia #shortvideo #influencermarketing #datascraping #apify #creatoreconomy

## License

The example code in this repository is released under the MIT License — see [LICENSE](./LICENSE).
It does not cover the Actor itself, which remains closed-source and is operated by its developer on Apify.
