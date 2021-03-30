# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


pages = Page.create([
	{ name: 'root', head: '0', body: 'text 0', path: '', nesting: 0, page_id: nil },
	{ name: 't1', head: 't1', body: 'text t1', path: 't1', nesting: 1, page_id: 1 },
	{ name: 't1_1', head: 't1-1', body: 'text t1-1', path: 't1/t11', nesting: 2, page_id: 2 },
	{ name: 't1_2', head: 't1-2', body: 'text t1-2', path: 't1/t12', nesting: 2, page_id: 2 },
	{ name: 't1_2_1', head: 't1-2-1', body: 'text t1-2-1', path: 't1/t12/t121', nesting: 3, page_id: 4 },
	{ name: 't2', head: 't2', body: 'text t2', path: 't2', nesting: 1, page_id: 1 }
	])
