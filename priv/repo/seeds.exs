# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SwStore.Repo.insert!(%SwStore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

    
SwStore.Repo.insert!(%SwStore.Catalog.Product{
	name: "Macbook Pro",
    price: 200000,
    published: true,
    sku: "KVZ001234",
    description: "some text about this product"
})

SwStore.Repo.insert!(%SwStore.Catalog.Product{
	name: "Macbook Air",
    price: 180000,
    published: true,
    sku: "KVZ001235",
    description: "some text about this product"
})

SwStore.Repo.insert!(%SwStore.Catalog.Product{
	name: "iPhone",
    price: 80000,
    published: true,
    sku: "KVZ001236",
    description: "some text about this product"
})