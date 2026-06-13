CREATE DATABASE Tables;
USE Tables;

CREATE TABLE UnidadesMedida(
    idUnidad INT AUTO_INCREMENT PRIMARY KEY,
    NombreUnidad VARCHAR(50),
    Abreviatura VARCHAR(10),
    Descripcion TEXT,
    EsCompuesta BOOLEAN DEFAULT TRUE,
    UnidadBase VARCHAR(50),
    CantidadPorUnidad DECIMAL(10,2),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP()
);

CREATE TABLE Proveedores(
    idProveedor INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(200),
    NombreContacto VARCHAR(150),
    Telefono VARCHAR(30),
    Email VARCHAR(100),
    Direccion TEXT,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP()
);

CREATE TABLE Productos(
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    CodigoProducto VARCHAR(50),
    NombreProducto VARCHAR(200),
    Descripcion TEXT,
    Marca VARCHAR(100),
    Especificacion VARCHAR(20),
    TipoAceite VARCHAR(20),
    idUnidad INT,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP(),
    FechaActualizacion TIMESTAMP(),
    FOREIGN KEY (idUnidad) REFERENCES Unidad(idUnidad)
);

CREATE TABLE ProductoProveedores(
    idProductoProveedor INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT,
    idProveedor INT,
    CodigoProveedor VARCHAR(100),
    PrecioReferencia DECIMAL(10,2),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP()
);

CREATE TABLE Sucursales(
    idSucursal INT AUTO_INCREMENT PRIMARY KEY,
    CodigoSucursal VARCHAR(20),
    NombreSucursal VARCHAR(100),
    Direccion TEXT,
    Telefono VARCHAR(30),
    Responsable VARCHAR(100),
    Activo BOOLEAN DEFAULT,
    FechaCreacion TIMESTAMP()
);

CREATE TABLE InventarioSucursales(
    idSucursal INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT,
    StockMinimo DECIMAL(10,2),
    StockActual DECIMAL(10,2),
    FechaActualizacion TIMESTAMP(),
    Activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE FacturasCompra(
    idFacturaCompra INT AUTO_INCREMENT PRIMARY KEY,
    NumeroFactura VARCHAR(50),
    idProveedor INT,
    idSucursal INT,
    FechaFactura DATE,
    FechaRegistro TIMESTAMP(),
    Subtotal DECIMAL(12,2),
    Impuesto DECIMAL(12,2),
    Total DECIMAL(12,2)
    Observaciones TEXT,
    Activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE FacturasCompraDetalle(
    idDetalleFactura INT AUTO_INCREMENT PRIMARY KEY,
    idFacturaCompra INT,
    idProducto INT,
    Cantidad DECIMAL(10,2),
    PrecioUnitario DECIMAL(10,2),
    TotalLinea DECIMAL(12,2),
    Observaciones VARCHAR(255)
);

CREATE TABLE HistorialPreciosCompra(
    idPrecio INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT,
    Cantidad DECIMAL(10,2),
    PrecioCompra DECIMAL(10,2),
    TotalCompra DECIMAL(10,2),
    FechaPrecio TIMESTAMP(),
    Proveedor VARCHAR(200),
    NumeroFactura VARCHAR(50),
    Observaciones TEXT,
    Activo BOOLEAN DEFAULT TRUE,
    UsuarioRegistro VARCHAR(100)
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

CREATE TABLE ComposicionProductos(
    idComposicion INT AUTO_INCREMENT PRIMARY KEY,
    idProductoPadre INT,
    idProductoHijo INT,
    CantidadPorCaja DECIMAL(10,2),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP()
);