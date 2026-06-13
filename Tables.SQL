-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS Tables;
USE Tables;

CREATE TABLE UnidadesMedida(
    IdUnidad INT AUTO_INCREMENT PRIMARY KEY,
    NombreUnidad VARCHAR(50) NOT NULL,
    Abreviatura VARCHAR(10) NOT NULL,
    Descripcion TEXT,
    EsCompuesta BOOLEAN DEFAULT TRUE,
    UnidadBase VARCHAR(50),
    CantidadPorUnidad DECIMAL(10,2),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Proveedores(
    IdProveedor INT AUTO_INCREMENT PRIMARY KEY,
    NombreProveedor VARCHAR(200) NOT NULL,
    NombreContacto VARCHAR(150),
    Telefono VARCHAR(30),
    Email VARCHAR(100),
    Direccion TEXT,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Sucursales(
    IdSucursal INT AUTO_INCREMENT PRIMARY KEY,
    CodigoSucursal VARCHAR(20) NOT NULL,
    NombreSucursal VARCHAR(100) NOT NULL,
    Direccion TEXT,
    Telefono VARCHAR(30),
    Responsable VARCHAR(100),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Productos(
    IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    CodigoProducto VARCHAR(50) NOT NULL,
    NombreProducto VARCHAR(200) NOT NULL,
    Descripcion TEXT,
    Marca VARCHAR(100),
    Especificacion VARCHAR(20),
    TipoAceite VARCHAR(20),
    IdUnidad INT NOT NULL,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FechaActualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (IdUnidad) REFERENCES UnidadesMedida(IdUnidad)
);

CREATE TABLE ProductoProveedores(
    IdProductoProveedor INT AUTO_INCREMENT PRIMARY KEY,
    IdProducto INT NOT NULL,
    IdProveedor INT NOT NULL,
    CodigoProveedor VARCHAR(100),
    PrecioReferencia DECIMAL(10,2),
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto),
    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);

CREATE TABLE ComposicionProductos(
    IdComposicion INT AUTO_INCREMENT PRIMARY KEY,
    IdProductoPadre INT NOT NULL,
    IdProductoHijo INT NOT NULL,
    CantidadPorCaja DECIMAL(10,2) NOT NULL,
    Activo BOOLEAN DEFAULT TRUE,
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdProductoPadre) REFERENCES Productos(IdProducto),
    FOREIGN KEY (IdProductoHijo) REFERENCES Productos(IdProducto)
);

CREATE TABLE InventarioSucursales(
    IdInventarioSucursal INT AUTO_INCREMENT PRIMARY KEY,
    IdSucursal INT NOT NULL,
    IdProducto INT NOT NULL,
    StockMinimo DECIMAL(10,2),
    StockActual DECIMAL(10,2),
    FechaActualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

CREATE TABLE FacturasCompra(
    IdFacturaCompra INT AUTO_INCREMENT PRIMARY KEY,
    NumeroFactura VARCHAR(50) NOT NULL,
    IdProveedor INT NOT NULL,
    IdSucursal INT NOT NULL,
    FechaFactura DATE NOT NULL,
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Subtotal DECIMAL(12,2),
    Impuesto DECIMAL(12,2),
    Total DECIMAL(12,2),
    Observaciones TEXT,
    Activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor),
    FOREIGN KEY (IdSucursal) REFERENCES Sucursales(IdSucursal)
);

CREATE TABLE FacturasCompraDetalle(
    IdDetalleFactura INT AUTO_INCREMENT PRIMARY KEY,
    IdFacturaCompra INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad DECIMAL(10,2) NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    TotalLinea DECIMAL(12,2),
    Observaciones VARCHAR(255),
    FOREIGN KEY (IdFacturaCompra) REFERENCES FacturasCompra(IdFacturaCompra),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

CREATE TABLE HistorialPreciosCompra(
    IdPrecio INT AUTO_INCREMENT PRIMARY KEY,
    IdProducto INT NOT NULL,
    Cantidad DECIMAL(10,2) NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    TotalCompra DECIMAL(10,2),
    FechaPrecio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Proveedor VARCHAR(200),
    NumeroFactura VARCHAR(50),
    Observaciones TEXT,
    Activo BOOLEAN DEFAULT TRUE,
    UsuarioRegistro VARCHAR(100),
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);