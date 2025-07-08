from odoo import models, fields


class LibraryAuthor(models.Model):
    _name = "library.author"
    _description = "Autor de libro"

    name = fields.Char(string="Nombre", required=True)
    country = fields.Char(string="Pa\u00eds")
