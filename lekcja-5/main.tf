# Lekcja 5: New Relic jako kod. To samo, co robisz w pracy w UI, tylko w Terraformie.
#
# Klucz API i Account ID provider czyta ze zmiennych środowiskowych, więc nie ma ich w kodzie:
#   source ~/.config/newrelic-lab.env
# (NEW_RELIC_API_KEY, NEW_RELIC_ACCOUNT_ID, NEW_RELIC_REGION)

terraform {
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.0"
    }
  }
}

provider "newrelic" {}

# Przykład: polityka alertów. Jedna polityka grupuje warunki (jak twoje "Cisco ISE" w pracy).
resource "newrelic_alert_policy" "website" {
  name                = "Lekcja 5 - strona OFFREX"
  incident_preference = "PER_CONDITION_AND_TARGET" # osobny incydent na warunek i "target", jak twoje FACET per node
}

resource "newrelic_synthetics_monitor" "offrex" {
  name = "Check on Offrex.eu"
  type = "SIMPLE"
  uri = "https://offrex.eu"
  period = "EVERY_6_HOURS"
  status = "ENABLED"
  locations_public = ["EU_CENTRAL_1"]
}

resource "newrelic_nrql_alert_condition" "offrex_down" {
  name = "offrex.eu nie odpowiada"
  policy_id = newrelic_alert_policy.website.id
  type = "static"
  nrql {
    query = "SELECT count(*) FROM SyntheticCheck WHERE monitorName = '${newrelic_synthetics_monitor.offrex.name}' AND result = 'FAILED'"
  }

  critical {
    operator = "above"
    threshold = 0
    threshold_duration = 21600
    threshold_occurrences = "at_least_once"
  }
}


resource "newrelic_one_dashboard" "offrex" {
  name = "Offrex.eu Metrics"
  page {
    name = "Is Offrex UP"
    widget_billboard {
      title = "is_offrex_up"
      row = 0
      column = 0
      nrql_query {
        query = "SELECT percentage(count(*), WHERE result = 'SUCCESS') from SyntheticCheck SINCE 1 week ago"
      }
    }
  }
}

# TODO 3: dashboard z jednym kafelkiem "billboard" pokazującym, ile procent sprawdzeń się udało.
#   resource "newrelic_one_dashboard" "offrex" { name = ... page { name = ... widget_billboard { ... } } }
#   Zapytanie: SELECT percentage(count(*), WHERE result = 'SUCCESS') FROM SyntheticCheck SINCE 1 week ago
#   Poszukaj w podpowiedziach VS Code, jakie argumenty ma widget_billboard (title, row, column, nrql_query...).
