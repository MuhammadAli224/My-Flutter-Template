# AI Feature Commands

This document defines how AI should interpret feature creation requests.

When the user asks to create a feature:

```
Create feature: products
Endpoint: GET /products
Cache: true
```

AI must automatically:

1. Generate the feature folder
2. Create DTO, Entity, Mapper
3. Create Repository and Datasources
4. Create Cubit and State
5. Create Feature Page
6. Create DI registration
7. Update `global_imports.dart`
8. Add route constant
9. Register GoRouter route
10. Register DI in dependencies

---

# Example AI Request

User prompt:

```
Create feature products with endpoint GET /products
```

AI must generate:

```
feature/products/
```

and integrate it with:

```
global_imports.dart
routes.dart
dependencies_injection.dart
```

---

# Naming Rules

Feature name:

```
products
```

Generated classes:

```
ProductsDTO
ProductsEntity
ProductsRepository
ProductsRepositoryImpl
ProductsRemoteDataSource
ProductsCubit
ProductsPage
initProductsDI
```

---

# Route Name

```
static const products = "/products";
```

---

# Router Entry

```
GoRoute(
  path: AppRoutes.products,
  builder: (context, state) => const ProductsPage(),
)
```
