% MATLAB Smtoep Object for Toeplitz matrix
%
% Smtoep Functions, operators and methods.
%
% Smtoep object construction.
%   smtoep        - Toeplitz matrix class constructor.
%
% Getting parameters.
%   get           - Get smtoep object fields.
%
% Elementary math functions.
%   abs           - Absolute value.
%   angle         - Phase angle.
%   conj          - Complex conjugate.
%   imag          - Complex imaginary part.
%   real          - Complex real part.
%   fix           - Round towards zero.
%   floor         - Matrix element-wise floor.
%   ceil          - Matrix element-wise ceiling.
%   round         - Matrix element-wise round.
%   sign          - Signum function.
%
% Operators and special characters.
%   plus          - Plus                               +
%   uplus         - Unary plus                         +
%   minus         - Minus                              -
%   uminus        - Unary minus                        -
%   mtimes        - Matrix multiply                    *
%   times         - Array multiply                    .*
%   mpower        - Matrix power                       ^
%   power         - Array power                       .^
%   mldivide      - Backslash or left matrix divide    \
%   mrdivide      - Slash or right matrix divide       /
%   ldivide       - Left array divide                 .\
%   rdivide       - Right array divide                ./
%   transpose     - Transpose                         .'
%   ctranspose    - Complex conjugate transpose        '
%
% Basic array information.
%   size          - Size of a smtoep matrix.
%   length        - Length of a smtoep matrix.
%   display       - Display a matrix of the smtoep class.
%   isempty       - True for an empty smtoep matrix.
%   isequal       - True if smtoep objects are numerically equal.
%
% Array operations and manipulation.
%   diag          - Diagonals of a smtoep matrix.
%   diff          - Difference and approximate derivative.
%   full          - Convert smtoep matrix to a full matrix.
%   max           - Largest component.
%   min           - Smallest component.
%   prod          - Product of the elements.
%   reshape       - Change size of a smtoep matrix.
%   sum           - Sum of elements.
%   tril          - Extract lower triangular part.
%   triu          - Extract upper triangular part.
%
% Matrices and numerical linear algebra.
%   cond          - Condition number with respect to inversion.
%   det           - Determinant.
%   eig           - Eigenvalues and eigenvectors.
%   inv           - Matrix inverse.
%   norm          - Matrix or vector norm.
%
% Smtoep methods.
%   toeprem       - Toeplitz premultiplication.
%
% Array utility functions.
%   double        - Convert to double precision.
%   single        - Convert to single precision.
%   isa           - True if object is a given class.
%   isfloat       - True for floating point arrays, both single and double.
%   isreal        - True for real array.
%   smtvalid      - Determine if an object is a valid operand.
%   subsasgn      - Subscripted assignment into smtoep objects.
%   subsindex     - Subscript index for smtoep objects.
%   subsref       - Subscripted reference into smtoep objects.
%   end           - Last index in an indexing expression of a smtoep matrix.

% Smtoep fields.
%    t             - vector containing a Toeplitz matrix in TPS
%                    format.
%    dim1          - number of rows.
%    dim2          - number of columns.
%    cev           - eigenvalues of the circulant matrix in
%                    which the Toeplitz matrix is embedded.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 20, 2011
