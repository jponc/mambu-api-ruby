module Mambu
  module DocumentHelpers
    def create_attachment(document_attrs, content)
      data = { document: document_attrs, documentContent: content }
      Mambu::Document.create_attachment(self, data)
    end
  end
end
