# Falconz
> Falcon Malware Sandbox API Connector

## Installation

    $ gem install falconz

## Usage

Currently requires the `HYBRID_ANALYSIS_API_KEY` enviroment variable set to communicate with the API.

```ruby
require "falconz"

client = Falconz.client.new

client.number_of_environments

client.current_key

client.submit_file(file: "README.md", environment_id: 100)

client.search_hash("82d14e45e6a0586e66f359c6854bd90b6180b92d66d3db03e5e85234edfdcc04")
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
