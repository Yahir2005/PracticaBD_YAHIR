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

INSERT INTO UnidadesMedida 
(NombreUnidad, Abreviatura, Descripcion, EsCompuesta, UnidadBase, CantidadPorUnidad) 
VALUES
("Kilogramo","Kg","Unidad de masa equivalente a 1000 gramos",0,NULL,NULL),
("Gramo","g","Unidad de masa equivalente a 1/1000 de kilogramo",1,"Kilogramo",1000),
("Miligramo","mg","Unidad de masa equivalente a 1/1000 de gramo",1,"Gramo",1000);


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

INSERT INTO Proveedores(
    NombreProveedor,
    NombreContacto,
    Telefono,
    Email,
    Direccion
) VALUES
("Productos Vetales S.A  C.V","Daniel","232324432","Daniel@gmail.com","reforma s/n"),
("Telegramas S.A de C.V","Pedro","232243432","Pedro@gmail.com","Rafael Ayala s/n"),
("La Oriental C.V","Benito","2323434432","Benito@gmail.com","Los Heroes s/n");


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

INSERT INTO Sucursales(
    CodigoSucursal,
    NombreSucursal,
    Direccion,
    Telefono,
    Responsable
) VALUES
("12345","Sucursal 1","reforma s/n","2371893456","Daniel"),
("23456","Sucursal 2","Rafael Ayala s/n","2391032453","Pedro"),
("34567","Sucursal 3","Los Heroes s/n","2340981234","Benito");


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

INSERT INTO Productos(
    CodigoProducto,
    NombreProducto,
    Descripcion,
    Marca,
    Especificacion,
    TipoAceite,
    IdUnidad
) VALUES
("423324","Producto 1","Descripción 1","Marca 1","Especificación 1","Aceite 1",1),
("423423","Producto 2","Descripción 2","Marca 2","Especificación 2","Aceite 2",2),
("543434","Producto 3","Descripción 3","Marca 3","Especificación 3","Aceite 3",3);


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

INSERT INTO ProductoProveedores(
    IdProducto,
    IdProveedor,
    CodigoProveedor,
    PrecioReferencia
) VALUES
(1,1,"2342",234.0),
(2,2,"4323",40.0),
(3,3,"3243",234.0);


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

INSERT INTO ComposicionProductos(
    IdProductoPadre,
    IdProductoHijo,
    CantidadPorCaja
) VALUES
(1,2,30.0),
(2,3,40.0),
(1,3,30.0);


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

INSERT INTO InventarioSucursales(
    IdSucursal,
    IdProducto,
    StockMinimo,
    StockActual
) VALUES
(1,1,20.0,30.0),
(2,2,30.0,40.0),
(3,3,40.0,50.0);


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

INSERT INTO FacturasCompra(
    NumeroFactura,
    IdProveedor,
    IdSucursal,
    FechaFactura,
    Subtotal,
    Impuesto,
    Total,
    Observaciones
) VALUES
("324324",1,1,"2025-06-20",23.0,3.0,26.0,"Observación 1"),
("432344",2,2,"2026-06-21",25.0,5.0,30.0,"Observación 2"),
("234323",3,3,"2027-06-22",30.0,5.0,35.0,"Observación 3");


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

INSERT INTO FacturasCompraDetalle(
    IdFacturaCompra,
    IdProducto,
    Cantidad,
    PrecioUnitario,
    TotalLinea,
    Observaciones
) VALUES
(1,1,20.0,21.0,420.0,"Observación 1"),
(2,2,30.0,35.0,1050.0,"Observación 2"),
(3,3,40.0,45.0,1800.0,"Observación 3");


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

INSERT INTO HistorialPreciosCompra(
    IdProducto,
    Cantidad,
    PrecioCompra,
    TotalCompra,
    Proveedor,
    NumeroFactura,
    Observaciones
) VALUES
(1,20.0,30.0,600.0,"Proveedor 1","43432","Observaciones 1"),
(2,30.0,40.0,1200.0,"Proveedor 2","34323","Observaciones 2"),
(3,40.0,50.0,2000.0,"Proveedor 3","43323","Observaciones 3");

/*JOINS*/

/*JOIN de 2 tablas: Productos + UnidadesMedida para listar producto, codigo, unidad y abreviatura.*/


/*JOIN de 2 tablas: HistorialPreciosCompra + Productos para mostrar compras por producto y fecha*/


/*JOIN de 2 tablas: InventarioSucursales + Sucursales para visualizar stock por sucursal.*/


/*JOIN de 3 tablas: HistorialPreciosCompra + Productos + UnidadesMedida para vista de compras completa.*/


/*JOIN de 3 tablas: InventarioSucursales + Productos + Sucursales para reporte de inventario general.*/


/*JOIN de 3 tablas: ProductoProveedores + Productos + Proveedores para catalogo de proveedores por producto.*/


/*JOIN de 3 tablas: FacturasCompraDetalle + FacturasCompra + Productos para detalle de factura con datos del producto.*/