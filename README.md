# Falconz
> Falcon Malware Sandbox APIv2 Connector

<p align="center">
  <img alt="i like birds" src="https://github.com/picatz/falconz/blob/master/falcon.jpg"/>
<p>

[Falcon Sandbox](https://www.hybrid-analysis.com/docs/api/v2) has a powerful and simple API that can be used to submit files/URLs for analysis, pull report data, but also perform advanced search queries. The API is open and free to the entire IT-security community.

## Installation

    $ gem install falconz

## Usage

To create a client, we can specify our API key or set the `HYBRID_ANALYSIS_API_KEY` environment variable to communicate with the API.

```ruby
require "falconz"

client = Falconz.client.new(key: "your_api_key") 
```

Get the current file hashes that are being processed along with their environment IDs.
```ruby
client.in_progress
# => [{:hash=>"b8560ce1bacb5515fdaef7cb3615a8172663da749b038687ab4a439cbf64f23b", :environment=>"100"},
#  {:hash=>"4f456ae8d592a73be8e898384a6b78cf1406965bcb2cea38ffa976c1084acb74", :environment=>"120"},
#  {:hash=>"6e206c74d4b9796264e5e2cb351e563806320e8d6d794fba38d3be93aa4b1bb5", :environment=>"100"},
#  {:hash=>"8d5bd56a19d06d46c8e92552f0bf81fa38cbf3365ab022e97075810be18000d9", :environment=>"120"},
#  {:hash=>"497f631d332b6b242528409778ecb7a778b1b50d6964139b549fdd71410381bc", :environment=>"120"}]
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
client.search_hash("cc311a06612f1b420cf788bd8883fa9dbd34d33ba8fa2443b86b7f88c7a75c2c")
# => [{"job_id"=>"5ae641ad7ca3e175d57a6013",
#   "environment_id"=>"100",
#   "environment_description"=>"Windows 7 32 bit",
#   "size"=>3127633,
#   "type"=>"PE32 executable (GUI) Intel 80386, for MS Windows",
#   "type_short"=>["peexe"],
#   "target_url"=>nil,
#   "state"=>"SUCCESS",
#   "submit_name"=>"sospecha.exe",
#   "md5"=>"7421fed9ae4b6643913b080718b919cc",
#   "sha1"=>"4f86bc7a578b6ac9d1e5f1fc325917e436f60520",
#   "sha256"=>"cc311a06612f1b420cf788bd8883fa9dbd34d33ba8fa2443b86b7f88c7a75c2c",
#   "sha512"=>"684558a218f6039ba718bfeac763f529222474498a41fdfa6994c8a3955b2686c07fd053d1afab73b2403b9f98fd3cf7112faec220c1b12b574c6a7fea828a8b",
#   "ssdeep"=>"49152:32uJI9LH1MuvxlFl7Z0pnZASuwSpW/vnjC91R8rsiX8L1ViGiJJLQRRtaU:muwLH6oF0pZAS6W/vWzRo8iGi2RtaU",
#   "imphash"=>"884310b1928934402ea6fec1dbd3cf5e",
#   "av_detect"=>1,
#   "vx_family"=>"TSGeneric",
#   "url_analysis"=>false,
#   "analysis_start_time"=>"2018-04-30T00:06:01-05:00",
#   "threat_score"=>85,
#   "interesting"=>false,
#   "threat_level"=>2,
#   "verdict"=>"malicious",
#   "certificates"=>[],
#   "domains"=>[],
#   "classification_tags"=>[],
#   "compromised_hosts"=>[],
#   "hosts"=>[],
#   "total_network_connections"=>0,
#   "total_processes"=>5,
#   "total_signatures"=>56,
#   "extracted_files"=>[],
#   "processes"=>[],
#   "file_metadata"=>nil}]
```

Check the number of environments available to use.
```ruby
client.number_of_environments
# => 5
```

Get the available environments ID numbers.
```ruby
client.environment_ids
# => [100, 110, 120, 300, 200]
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
