# Falconz
> Falcon Malware Sandbox APIv2 Connector

<p align="center">
  <img alt="i like birds" src="falcon.jpg"/>
<p>

[Falcon Sandbox](https://www.hybrid-analysis.com/docs/api/v2) has a powerful and simple API that can be used to submit files/URLs for analysis, pull report data, but also perform advanced search queries. The API is open and free to the entire IT-security community.

## Installation

    $ gem install falconz

## Usage

Currently requires the `HYBRID_ANALYSIS_API_KEY` environment variable set to communicate with the API.

```ruby
require "falconz"

client = Falconz.client.new
```

Upload a local file to the sandbox.
```ruby
client.submit_file(file: "malware.exe", environment_id: 100)
# => {"job_id"=>"5acc00b27ca3e138c14ab0e4",
#     "environment_id"=>"100",
#     "sha256"=>"015e5c626b993855fa88ce4c9758bc780fac3774c3d8bfcfae62833affc31e00"}
```

Search for results related to a given hash (MD5/SHA1/SHA256).
```ruby
# md5
client.search_hash("4d86e66537ac0130cce541890e1d9c4b")

# sha1
client.search_hash("62f585da3fea334b83cb8b4cee9b605d901c825c")

# sha256
client.search_hash("82d14e45e6a0586e66f359c6854bd90b6180b92d66d3db03e5e85234edfdcc04")
```

Check the number of environments available to use.
```ruby
client.number_of_environments
# => 5
```

Get information about current API key being used.
```ruby
client.current_key
# => {"api_key"=>"130cce541890e1d9c4b34b83cb8b4cee9854bd90b6180b9",
#  "auth_level"=>100,
#  "auth_level_name"=>"default",
#  "user"=>
#   {"id"=>"4cee9b605d901c825c",
#    "email"=>"kgruber1@emich.edu",
#    "name"=>"picat"}}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
