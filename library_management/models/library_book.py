from odoo import models, fields


class LibraryBook(models.Model):
    _name = "library.book"
    _description = "Libro"

    title = fields.Char(string="T\u00edtulo", required=True)
    author_id = fields.Many2one("library.author", string="Autor")
    publish_date = fields.Date(string="Fecha de publicaci\u00f3n")
    state = fields.Selection(
        [
            ("available", "Disponible"),
            ("borrowed", "Prestado"),
        ],
        string="Estado",
        default="available",
    )
