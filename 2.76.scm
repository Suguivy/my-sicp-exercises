#|

Operaciones genéricas con dispatch explícito:
- Para añadir un nuevo tipo, se debe modificar cada selector genérico para soportar el nuevo tipo.
- Para añadir una nueva operación, se debe crear un selector genérico con sus correspondientes selectores de tipo específicos.

Data-directed:
- Para añadir un nuevo tipo, se debe crear un paquete del tipo deseado e instalarlo.
- Para añadir una nueva operación, se debe implementar esa operación en cada paquete, y luego crear la operación genérica.

Message-passing:
- Para añadir un nuevo tipo, se crea el constructor del tipo y dentro, en el dispatch, se define el comportamiento según el mensaje (operación.
- Para añadir una nueva operación, se crea un nuevo comportamiento en el dispatch de cada tipo.

New types must often be added: Data-directed.
New operations must often be added: Message-passing.

|#
