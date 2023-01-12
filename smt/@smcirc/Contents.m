% MATLAB Smcirc Object for Circulant matrix
%
% Smcirc Functions and operators.
%
% Smcirc object construction.
%   smcirc        - Circulant matrix class constructor.
%
% Getting parameters.
%   get           - Get smcirc object fields.
%
% Elementary math functions.
%   abs           - Absolute value.
%   angle         - Phase angle.
%   conj          - Complex conjugate.
%   imag          - Complex imaginary part.
%   real          - Complex real part.
%   fix           - Matrix element-wise integer part.
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
%   size          - Size of a smcirc matrix.
%   length        - Length of a smcirc matrix.
%   display       - Display a matrix of the smcirc class.
%   isempty       - True for an empty smcirc matrix.
%   isequal       - True if smcirc objects are numerically equal.
%
% Array operations and manipulation.
%   diag          - Diagonals of a smcirc matrix.
%   diff          - Difference and approximate derivative.
%   full          - Convert smcirc matrix to a full matrix.
%   max           - Largest component.
%   min           - Smallest component.
%   prod          - Product of elements.
%   reshape       - Change size of a smcirc matrix.
%   sum           - Sum of elements.
%   smtoep        - Create a smtoep matrix from a smcirc matrix.
%   tril          - Extract lower triangular part.
%   triu          - Extract upper triangular part.
%
% Matrices and numerical linear algebra.
%   cond          - Condition number with respect to inversion.
%   det           - Determinant.
%   eig           - Eigenvalues and eigenvectors of a smcirc matrix.
%   inv           - smcirc matrix inverse.
%   norm          - Matrix or vector norm.
%
% Array utility functions.
%   double        - Convert to double precision.
%   single        - Convert to single precision.
%   isa           - True if object is a given class.
%   isfloat       - True for floating point arrays, both single and double.
%   isreal        - True for real array.
%   smtvalid      - Determine if an object is a valid operand.
%   subsasgn      - Subscripted assignment into smcirc objects.
%   subsindex     - Subscript index for smcirc objects.
%   subsref       - Subscripted reference into smcirc objects.
%   end           - Last index in an indexing expression of a smcirc matrix.

% Smcirc fields.
%    c             - vector containing the first column of the
%                    circulant matrix.
%    dim           - dimension of the matrix.
%    ev            - eigenvalues of the circulant matrix.

%  Michela Redivo-Zaglia, University of Padova, Italy
%       Email: Michela.RedivoZaglia@unipd.it
%  Giuseppe Rodriguez, University of Cagliari, Italy
%       Email: rodriguez@unica.it
%
%  Last revised May 20, 2011
