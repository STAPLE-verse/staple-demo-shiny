library(rorcid)
library(dplyr)
library(purrr)

# orcid_auth()
# usethis::edit_r_environ()

orcid_to_get <- "0000-0002-9948-1195"
orcid_person <- orcid_person(orcid_to_get)

orcid_data <- orcid_person %>% {
  dplyr::tibble(
    created_date = purrr::map_dbl(., purrr::pluck, "name", "created-date", "value", .default=NA_integer_),
    given_name = purrr::map_chr(., purrr::pluck, "name", "given-names", "value", .default=NA_character_),
    family_name = purrr::map_chr(., purrr::pluck, "name", "family-name", "value", .default=NA_character_),
    credit_name = purrr::map_chr(., purrr::pluck, "name", "credit-name", "value", .default=NA_character_),
    # other_names = purrr::map(., purrr::pluck, "other-names", "other-name", "content", .default=NA_character_),
    orcid_identifier_path = purrr::map_chr(., purrr::pluck, "name", "path", .default = NA_character_),
    # biography = purrr::map_chr(., purrr::pluck, "biography", "content", .default=NA_character_),
    # researcher_urls = purrr::map(., purrr::pluck, "researcher-urls", "researcher-url", .default=NA_character_),
    # emails = purrr::map(., purrr::pluck, "emails", "email", "email", .default=NA_character_)
    # keywords = purrr::map(., purrr::pluck, "keywords", "keyword", "content", .default=NA_character_)
    #external_ids = purrr::map(., purrr::pluck, "external-identifiers", "external-identifier", .default=NA_character_)
  )
}
orcid_data
