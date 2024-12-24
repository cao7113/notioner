import Config

# Demo internal integration data-helper('notion' word not allowed)
# - https://www.notion.so/profile/integrations/internal/58e2844cd10d4fe6b16129f299e014a3
# - https://www.notion.so/shareupme/408b771f00ff409e8bcab2c6c609b2a9?v=328c08a080ab428c8a161f8f85132476&pvs=4
# Note:
# - all below database should be granted to above integration.
# - all children pages(database rows) automatically granted after previous grant!

import_config "#{Mix.env()}.exs"
