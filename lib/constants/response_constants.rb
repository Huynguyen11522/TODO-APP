module ResponseConstants

  STATUS_MESSAGE = {
    success: "Operation successful.",
    error: "An error occurred.",
    not_found: "Record not found.",
    bad_request: "Bad Request.",
    create: "Create successfully.",
    update: "Update successfully.",
    delete: "Delete successfully.",
    filter: "Filter successfully"
  }.freeze

  STATUS_CODE = {
    ok: 200,
    created: 201,
    bad_request: 400,
    unauthoirized: 401,
    forbidden: 403,
    not_found: 404,
    internal_er: 500
  }.freeze
end