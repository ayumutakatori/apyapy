# Slapi

自分が雑に外部サービスのapiリクエストをするとき用のクライアントです。

# Usage

```irb

# 1. Prepare
## 1-a. Existing access_token
> base_url = "https://example.com"
> access_token = "<YOUR_ACCESS_TOKEN>"
> client = Slapi::Client(base_url, access_token)

## 1-b. Existing client id & client secret
> base_url = "https://example.com"
> client = Slapi::Client(base_url)
> client_id = "<YOUR_CLIENT_ID>"
> client_secret = "<YOUR_CLIENT_SECRET>"
> client.authentiate!(client_id, client_secret) # => set access_token


# 2. Request
> path = "v1/users/aaabbbsss"
> params = "filter=closed&order=asc"
> response = client.get(path, query)
> p response

```