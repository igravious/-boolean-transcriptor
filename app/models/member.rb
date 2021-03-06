#encoding: UTF-8

class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def special?
    # not implemented yet :(
    # next in line buddy
    # current_collection.editor? email
    admin == true
  end

  def bless
    self.admin = true
    self.save!
  end 

  def unbless
    self.admin = false
    self.save!
  end 

  def matches_whodunnit? model
    id == model.versions.last.whodunnit.to_i
  end

  def self.transcription_accept model, narrative
    member = Member.find(model.versions[-2].whodunnit.to_i)
    scan = model
    story = narrative
    accept_reject = "ACCEPTED"
    Rails.logger.info member.inspect
    member.scans_accepted += 1
    member.save
    MemberMailer.accept_reject_story(member, scan, story, accept_reject).deliver
  end

  def self.transcription_reject model, narrative
    member = Member.find(model.versions[-2].whodunnit.to_i)
    scan = model
    story = narrative
    accept_reject = "REJECTED"
    MemberMailer.accept_reject_story(member, scan, story, accept_reject).deliver
  end

  # https://stackoverflow.com/questions/4110866/ruby-on-rails-where-to-define-global-constants
  #
  # https://stackoverflow.com/questions/3856737/where-how-to-code-constants-in-rails-3-application

  before_create :auto_gen_member_name
  
  def auto_gen_member_name
    self.nick = Member::gen_member_name
    Rails.logger.info(nick)
    Rails.logger.info("self #{self.inspect}")
  end

  def self.gen_member_name
    (Member::adjectives.sample.capitalize+" "+Member::mathematical_names.sample).gsub(/\s+/, ' ')
  end

  def self.mathematical_names
[
"Abscissa",
"Absolute Convergence",
"Absolute Maximum",
"Absolute Minimum",
"Absolute Value",
"Absolute Value Rules",
"Absolutely Convergent",
"Acceleration",
"Accuracy",
"Acute Angle",
"Acute Triangle",
"Addition Rule",
"Adjacent",
"Adjacent Angles",
"Adjoint",
"Affine Transformation",
"Aleph Null (א0)",
"Algebra",
"Algebraic Numbers",
"Algorithm",
"Alpha (Α α)",
"Alternate Angles",
"Alternating Series",
"Altitude",
"Amplitude",
"Analytic Geometry",
"Analytic Methods",
"Angle",
"Angle Bisector",
"Angle of Depression",
"Angle of Elevation",
"Annulus",
"Anticlockwise",
"Antiderivative",
"Antipodal Points",
"Apex",
"Apothem",
"Approximation",
"Arc",
"Arccos",
"Arccosec",
"Arccot",
"Arccsc",
"Arcsec",
"Arcsin",
"Arctan",
"Area",
"Argand Plane",
"Argument",
"Arithmetic",
"Arithmetic Mean",
"Arithmetic Progression",
"Arithmetic Sequence",
"Arithmetic Series",
"Associative",
"Asymptote",
"Augmented Matrix",
"Average",
"Average Rate of Change",
"Average Value of a Function",
"Axes",
"Axiom",
"Axis of a Cylinder",
"Axis of Reflection",
"Axis of Rotation",
"Axis of Symmetry",
"Back Substitution",
"Base (Geometry)",
"Base of a Trapezoid",
"Base of a Triangle",
"Bearing",
"Bernoulli Trials",
"Beta (Β β)",
"Between",
"Biconditional",
"Binomial",
"Binomial Coefficients",
"Binomial Probability Formula",
"Binomial Theorem",
"Bisect",
"Bisector",
"Boundary Value Problem",
"Bounded Function",
"Bounded Sequence",
"Bounded Set of Numbers",
"Bounds of Integration",
"Box",
"Box and Whisker Plot",
"Boxplot",
"Braces",
"Brachistochrone",
"Brackets",
"Calculus",
"Cardinal Numbers",
"Cardinality",
"Cardioid",
"Cartesian Coordinates",
"Cartesian Form",
"Cartesian Plane",
"Catenary",
"Cavalieri’s Principle",
"Ceiling Function",
"Center of Mass Formula",
"Center of Rotation",
"Centers of a Triangle",
"Central Angle",
"Centroid",
"Centroid Formula",
"Ceva’s Theorem",
"Cevian",
"Chain Rule",
"Change of Base Formula",
"Check a Solution",
"Chi (Χ χ)",
"Chord",
"Circle",
"Circle Identities",
"Circle Trig Definitions",
"Circular Cone",
"Circular Cylinder",
"Circular Functions",
"Circumcenter",
"Circumcircle",
"Circumference",
"Circumscribable",
"Circumscribed",
"Circumscribed Circle",
"Cis",
"Clockwise",
"Closed Interval",
"Coefficient",
"Coefficient Matrix",
"Cofactor",
"Cofactor Matrix",
"Cofunction Identities",
"Coincident",
"Collinear",
"Column of a Matrix",
"Combination",
"Combination Formula",
"Combinatorics",
"Common Logarithm",
"Common Ratio",
"Commutative",
"Comparison Test",
"Compatible Matrices",
"Complement of a Set",
"Complement of an Angle",
"Complement of an Event",
"Complementary Angles",
"Complex Conjugate",
"Complex Fraction",
"Complex Number Formulas",
"Complex Numbers",
"Complex Plane",
"Composite",
"Composite Number",
"Composition",
"Compound Fraction",
"Compound Inequality",
"Compound Interest",
"Compounded",
"Compounded Continuously",
"Compression",
"Compression of a Graph",
"Compute",
"Concave",
"Concave Down",
"Concave Up",
"Concentric",
"Conclusion",
"Concurrent",
"Conditional",
"Conditional Convergence",
"Conditional Equation",
"Conditional Inequality",
"Conditional Probability",
"Cone",
"Cone Angle",
"Congruence Tests for Triangles",
"Congruent",
"Conic Sections",
"Conjecture",
"Conjugate Pair Theorem",
"Conjugates",
"Conjunction",
"Consecutive Interior Angles",
"Constant",
"Constant Function",
"Constant Term",
"Continued Sum",
"Continuous",
"Continuous Compounding",
"Continuous Function",
"Contraction",
"Contrapositive",
"Converge",
"Converge Absolutely",
"Converge Conditionally",
"Convergence Tests",
"Convergent Sequence",
"Convergent Series",
"Converse",
"Convex",
"Coordinate Geometry",
"Coordinate Plane",
"Coordinates",
"Coplanar",
"Corollary",
"Correlation",
"Correlation Coefficient",
"Corresponding",
"cos",
"cosec",
"cosecant",
"cosine",
"cot",
"Cotangent",
"Coterminal",
"Countable",
"Countably Infinite",
"Counterclockwise",
"Counterexample",
"Counting Numbers",
"Cramer’s Rule",
"Critical Number",
"Critical Point",
"Critical Value",
"Cross Product",
"Cube",
"Cube Root",
"Cubic Polynomial",
"Cuboid",
"Curly d",
"Curve",
"Curve Sketching",
"Cusp",
"Cycloid",
"Cylinder",
"Cylindrical Shell Method",
"De Moivre’s Theorem",
"Decagon",
"Deciles",
"Decreasing Function",
"Definite Integral",
"Definite Integral Rules",
"Degenerate",
"Degenerate Conic Sections",
"Degree",
"Degree of a Polynomial",
"Degree of a Term",
"Del Operator",
"Deleted Neighborhood",
"Delta (Δ δ)",
"Denominator",
"Dependent Variable",
"Derivative",
"Derivative of a Power Series",
"Derivative Rules",
"Descartes' Rule of Signs",
"Determinant",
"Diagonal Matrix",
"Diagonal of a Polygon",
"Diameter",
"Diametrically Opposed",
"Difference",
"Difference Identities",
"Difference Quotient",
"Differentiable",
"Differential",
"Differential Equation",
"Differentiation",
"Differentiation Rules",
"Digit",
"Dihedral Angle",
"Dilation",
"Dilation of a Geometric Figure",
"Dilation of a Graph",
"Dimensions",
"Dimensions of a Matrix",
"Direct Proportion",
"Direct Variation",
"Directly Proportional",
"Directrices of a Hyperbola",
"Directrices of an Ellipse",
"Directrix of a Parabola",
"Discontinuity",
"Discontinuous Function",
"Discrete",
"Discriminant of a Quadratic",
"Disjoint Events",
"Disjoint Sets",
"Disjunction",
"Disk",
"Disk Method",
"Distance",
"Distance Formula",
"Distinct",
"Distribute",
"Distributing Rules",
"Diverge",
"Divergent Sequence",
"Divergent Series",
"Dodecagon",
"Dodecahedron",
"Domain",
"Domain of Definition",
"Dot Product",
"Double Angle Identities",
"Double Cone",
"Double Number Identities",
"Double Root",
"Doubling Time",
"e",
"Eccentricity",
"Echelon Form of a Matrix",
"Edge of a Polyhedron",
"Element of a Matrix",
"Element of a Set",
"Ellipse",
"Ellipsoid",
"Elliptic Geometry",
"Empty Set",
"End Behavior",
"Epsilon (Ε ε)",
"Equality, Properties of",
"Equation",
"Equation of a Line",
"Equation Rules",
"Equiangular Triangle",
"Equidistant",
"Equilateral Triangle",
"Equivalence Properties of Equality",
"Equivalence Relation",
"Equivalent Systems of Equations",
"Essential Discontinuity",
"Eta (Η η)",
"Euclidean Geometry",
"Euler Line",
"Euler's Formula",
"Euler's Formula (Polyhedra)",
"Evaluate",
"Even Function",
"Even Number",
"Event",
"Exact Values of Trig Functions",
"Exclusive (interval)",
"Exclusive or",
"Expand",
"Expansion by Cofactors",
"Expected Value",
"Experiment",
"Explicit Differentiation",
"Explicit Function",
"Exponent",
"Exponent Rules",
"Exponential Decay",
"Exponential Function",
"Exponential Growth",
"Exponential Model",
"Exponentiation",
"Expression",
"Exterior Angle of a Polygon",
"Extraneous Solution",
"Extreme Value Theorem",
"Extremum",
"Face of a Polyhedron",
"Factor of a Polynomial",
"Factor of an Integer",
"Factor Theorem",
"Factor Tree",
"Factorial",
"Factoring Rules",
"Falling Bodies",
"Fibonacci Sequence",
"Finite",
"First Derivative",
"First Derivative Test",
"First Quartile",
"Five Number Summary",
"Fixed",
"Flip",
"Floor Function",
"Focal Radius",
"Foci of a Hyperbola",
"Foci of an Ellipse",
"Focus",
"Focus of a Parabola",
"FOIL Method",
"Formula",
"Fractal",
"Fraction",
"Fraction Rules",
"Fractional Equation",
"Fractional Exponents",
"Fractional Expression",
"Frequency",
"Frustum",
"Function",
"Function Operations",
"Fundamental Theorem of Algebra",
"Fundamental Theorem of Arithmetic",
"Fundamental Theorem of Calculus",
"Gambling Odds",
"Gamma (Γ γ)",
"Gauss-Jordan Elimination",
"Gaussian Elimination",
"Gaussian Integer",
"GCF",
"Geometric Figure",
"Geometric Mean",
"Geometric Progression",
"Geometric Sequence",
"Geometric Series",
"Geometric Solid",
"Geometry",
"GLB",
"Glide",
"Glide Reflection",
"Global Maximum",
"Global Minimum",
"Golden Mean",
"Golden Ratio",
"Golden Rectangle",
"Golden Spiral",
"Googol",
"Googolplex",
"Graph",
"Graphic Methods",
"Gravity",
"Great Circle",
"Greatest Common Factor",
"Greatest Integer Function",
"Greatest Lower Bound",
"Greek Alphabet",
"Half Angle Identities",
"Half Number Identities",
"Half-Closed Interval",
"Half-Life",
"Half-Open Interval",
"Harmonic Mean",
"Harmonic Progression",
"Harmonic Sequence",
"Harmonic Series",
"Height",
"Height of a Cone",
"Height of a Cylinder",
"Height of a Parallelogram",
"Height of a Prism",
"Height of a Pyramid",
"Height of a Trapezoid",
"Height of a Triangle",
"Helix",
"Heptagon",
"Hero’s Formula",
"Heron’s Formula",
"Hexagon",
"Hexahedron",
"High Quartile",
"Higher Derivative",
"Higher Quartile",
"HL Congruence",
"HL Similarity",
"Hole",
"Homogeneous System of Equations",
"Horizontal",
"Horizontal Compression",
"Horizontal Dilation",
"Horizontal Ellipse",
"Horizontal Hyperbola",
"Horizontal Line Equation",
"Horizontal Line Test",
"Horizontal Parabola",
"Horizontal Reflection",
"Horizontal Shift",
"Horizontal Shrink",
"Horizontal Stretch",
"Horizontal Translation",
"Hyperbola",
"Hyperbolic Geometry",
"Hyperbolic Trig",
"Hyperbolic Trigonometry",
"Hypotenuse",
"Hypothesis",
"i",
"Icosahedron",
"Identity (Equation)",
"Identity Function",
"Identity Matrix",
"Identity of an Operation",
"if and only if",
"If-Then Statement",
"iff",
"Image of a Transformation",
"Imaginary Numbers",
"Imaginary Part",
"Implicit Differentiation",
"Implicit Function or Relation",
"Impossible Event",
"Improper Fraction",
"Improper Integral",
"Improper Rational Expression",
"Incenter",
"Incircle",
"Inclusive (interval)",
"Inclusive or",
"Inconsistent System of Equations",
"Increasing Function",
"Indefinite Integral",
"Indefinite Integral Rules",
"Independent Events",
"Independent Variable",
"Indeterminate Expression",
"Indirect Proof",
"Induction",
"Inequality",
"Inequality Rules",
"Infinite",
"Infinite Geometric Series",
"Infinite Limit",
"Infinite Series",
"Infinitesimal",
"Infinity",
"Inflection Point",
"Initial Side of an Angle",
"Initial Value Problem",
"Inner Product",
"Inradius",
"Inscribed Angle in a Circle",
"Inscribed Circle",
"Instantaneous Acceleration",
"Instantaneous Rate of Change",
"Instantaneous Velocity",
"Integers",
"Integrable Function",
"Integral",
"Integral Methods",
"Integral of a Function",
"Integral of a Power Series",
"Integral Rules",
"Integral Table",
"Integral Test",
"Integral Test Remainder",
"Integrand",
"Integration",
"Integration by Parts",
"Integration by Substitution",
"Integration Methods",
"Interest",
"Interior",
"Interior Angle",
"Intermediate Value Theorem",
"Interquartile Range",
"Intersection",
"Interval",
"Interval Notation",
"Interval of Convergence",
"Invariant",
"Inverse",
"Inverse Cosecant",
"Inverse Cosine",
"Inverse Cotangent",
"Inverse Function",
"Inverse of a Conditional",
"Inverse of a Matrix",
"Inverse of an Operation",
"Inverse Proportion",
"Inverse Secant",
"Inverse Sine",
"Inverse Tangent",
"Inverse Trig",
"Inverse Trig Functions",
"Inverse Trigonometry",
"Inverse Variation",
"Inversely Proportional",
"Invertible Matrix",
"Iota (Ι ι)",
"Irrational Numbers",
"Isometry",
"Isosceles Trapezoid",
"Isosceles Triangle",
"Iterative Process",
"Joint Variation",
"Jump Discontinuity",
"Kappa (Κ κ)",
"Kite",
"L'Hôpital's Rule",
"Lambda (Λ λ)",
"Lateral Area",
"Lateral Surface Area",
"Lateral Surface/Face",
"Latus Rectum",
"Law of Cosines",
"Law of Sines",
"LCM",
"Leading Coefficient",
"Leading Term",
"Least Common Denominator",
"Least Common Multiple",
"Least Integer Function",
"Least Upper Bound",
"Least-Squares Fit",
"Least-Squares Line",
"Least-Squares Regression Line",
"Leg of a Right Triangle",
"Leg of a Trapezoid",
"Leg of an Isosceles Triangle",
"Lemma",
"Lemniscate",
"Like Terms",
"Limaçon",
"Limit",
"Limit Comparison Test",
"Limit from Above",
"Limit from Below",
"Limit from the Left",
"Limit from the Right",
"Limit Involving Infinity",
"Limit Test for Divergence",
"Limits of Integration",
"Line",
"Line Segment",
"Linear",
"Linear Combination",
"Linear Equation",
"Linear Factorization",
"Linear Fit",
"Linear Inequality",
"Linear Pair of Angles",
"Linear Polynomial",
"Linear Programming",
"Linear Regression",
"Linear System of Equations",
"Local Behavior",
"Local Maximum",
"Local Minimum",
"Locus",
"Logarithm",
"Logarithm Rules",
"Logarithmic Differentiation",
"Logistic Growth",
"Long Division of Polynomials",
"Lower Bound",
"Lower Quartile",
"Maclaurin Series",
"Magnitude",
"Magnitude of a Vector",
"Main Diagonal of a Matrix",
"Major Arc",
"Major Axis of a Hyperbola",
"Major Axis of an Ellipse",
"Major Diameter of an Ellipse",
"Mathematical Model",
"Matrix",
"Matrix Addition",
"Matrix Element",
"Matrix Inverse",
"Matrix Multiplication",
"Matrix of Cofactors",
"Matrix Subtraction",
"Maximize",
"Maximum of a Function",
"Mean",
"Mean of a Random Variable",
"Mean Value Theorem",
"Mean Value Theorem for Integrals",
"Measure of an Angle",
"Measurement",
"Median of a Set of Numbers",
"Median of a Trapezoid",
"Median of a Triangle",
"Member of an Equation",
"Menelaus’s Theorem",
"Mensuration",
"Mesh",
"Midpoint",
"Midpoint Formula",
"Min/Max Theorem",
"Minimize",
"Minimum of a Function",
"Minor Arc",
"Minor Axis of a Hyperbola",
"Minor Axis of an Ellipse",
"Minor Diameter of an Ellipse",
"Minute",
"Mixed Number",
"Möbius Strip",
"Mode",
"Model",
"Modified Boxplot",
"Modular Arithmetic",
"Modular Equivalence",
"Modular Equivalence Rules",
"Modular Numbers",
"Modulo n",
"Modulus of a Complex Number",
"Modus Ponens",
"Modus Tolens",
"Moment",
"Monomial",
"Mu (Μ μ)",
"Multiplication Rule",
"Multiplicative Inverse of a Matrix",
"Multiplicative Inverse of a Number",
"Multiplicative Property of Equality",
"Multiplicity",
"Multivariable",
"Multivariable Analysis",
"Multivariable Calculus",
"Multivariate",
"Mutually Exclusive",
"n Dimensions",
"n-Dimensional",
"n-gon",
"n-tuple",
"Natural Domain",
"Natural Logarithm",
"Natural Numbers",
"Negative Direction",
"Negative Exponents",
"Negative Number",
"Negative Reciprocal",
"Negatively Associated Data",
"Neighborhood",
"Newton's Method",
"No Slope",
"Non-Adjacent",
"Non-Convex",
"Non-Euclidean Geometry",
"Non-Overlapping Sets",
"Nonagon",
"Noncollinear",
"Noninvertible Matrix",
"Nonnegative",
"Nonnegative Integers",
"Nonreal numbers",
"Nonsingular Matrix",
"Nontrivial",
"Nonzero",
"Norm of a Partition",
"Norm of a Vector",
"Normal",
"Normalizing a Vector",
"nth Degree Taylor Polynomial",
"nth Derivative",
"nth Partial Sum",
"nth Root",
"nth Root Rules",
"Nu (Ν ν)",
"Null Set",
"Number Line",
"Numerator",
"Oblate Spheroid",
"Oblique",
"Oblique Asymptote",
"Oblique Cone",
"Oblique Cylinder",
"Oblique Prism",
"Oblique Pyramid",
"Obtuse Angle",
"Obtuse Triangle",
"Octagon",
"Octahedron",
"Octants",
"Odd Function",
"Odd Number",
"Odd/Even Identities",
"Odds",
"Odds Against",
"Odds in Favor",
"Odds in Gambling",
"Omega (Ω ω)",
"Omicron (Ο ο)",
"One Dimension",
"One-Sided Limit",
"One-to-One Function",
"Open Interval",
"Operations on Functions",
"Opposite Reciprocal",
"Order of a Differential Equation",
"Ordered Pair",
"Ordered Triple",
"Ordinal Numbers",
"Ordinary Differential Equation",
"Ordinate",
"Origin",
"Orthocenter",
"Orthogonal",
"Outcome",
"Outlier",
"Oval",
"Overdetermined System of Equations",
"p-series",
"Paired Data",
"Pappus’s Theorem",
"Parabola",
"Parallel Cross Sections",
"Parallel Lines",
"Parallel Planes",
"Parallel Postulate",
"Parallelepiped",
"Parallelogram",
"Parameter (algebra)",
"Parametric Derivative Formulas",
"Parametric Equations",
"Parametric Integral Formula",
"Parametrize",
"Parent Functions",
"Parentheses",
"Partial Derivative",
"Partial Differential Equation",
"Partial Fractions",
"Partial Sum of a Series",
"Partition of a Positive Integer",
"Partition of a Set",
"Partition of an Interval",
"Pascal's Triangle",
"Pentagon",
"Per Annum",
"Percentile",
"Perfect Number",
"Perfect Square",
"Perimeter",
"Period of a Periodic Function",
"Period of Periodic Motion",
"Periodic Function",
"Periodic Motion",
"Periodicity Identities",
"Permutation",
"Permutation Formula",
"Perpendicular",
"Perpendicular Bisector",
"Phase Shift",
"Phi (Φ φ)",
"Pi (Π π)",
"Piecewise Continuous Function",
"Piecewise Function",
"Pinching Theorem",
"Plane",
"Plane Figure",
"Plane Geometry",
"Platonic Solids",
"Plus/Minus Identities",
"Point",
"Point of Division Formula",
"Point of Symmetry",
"Point-Slope Equation of a Line",
"Polar Angle of a Complex Number",
"Polar Axis",
"Polar Conversion Formulas",
"Polar Coordinates",
"Polar Curves",
"Polar Derivative Formulas",
"Polar Equation",
"Polar Form of a Complex Number",
"Polar Integral Formula",
"Polygon",
"Polygon Interior",
"Polyhedron",
"Polynomial",
"Polynomial Facts",
"Polynomial Long Division",
"Population",
"Positive Direction",
"Positive Number",
"Positive Series",
"Positively Associated Data",
"Postulate",
"Power",
"Power Rule",
"Power Series",
"Power Series Convergence",
"Pre-Image of a Transformation",
"Precision",
"Prime Factorization",
"Prime Number",
"Principal",
"Prism",
"Probability",
"Product",
"Product Rule",
"Product to Sum Identities",
"Projectile Motion",
"Prolate Spheroid",
"Proof by Contradiction",
"Proper Fraction",
"Proper Rational Expression",
"Proper Subset",
"Properties of Equality",
"Proportional",
"Psi (Ψ ψ)",
"Pure Imaginary Numbers",
"Pyramid",
"Pythagorean Identities",
"Pythagorean Theorem",
"Pythagorean Triple",
"QED",
"Quadrangle",
"Quadrantal Angle",
"Quadrants",
"Quadratic",
"Quadratic Equation",
"Quadratic Formula",
"Quadratic Polynomial",
"Quadrilateral",
"Quadruple",
"Quartic Polynomial",
"Quartiles",
"Quintic Polynomial",
"Quintiles",
"Quintuple",
"Quotient",
"Quotient Rule",
"Radian",
"Radical",
"Radical Rules",
"Radicand",
"Radius of a Circle or Sphere",
"Radius of Convergence",
"Range",
"Ratio",
"Ratio Identities",
"Ratio Test",
"Rational Equation",
"Rational Exponents",
"Rational Expression",
"Rational Function",
"Rational Numbers",
"Rational Root Theorem",
"Rational Zero Theorem",
"Rationalizing Substitutions",
"Rationalizing the Denominator",
"Ray",
"Real Numbers",
"Real Part",
"Reciprocal",
"Reciprocal Identities",
"Reciprocal Rule",
"Rectangle",
"Rectangular Coordinates",
"Rectangular Form",
"Rectangular Parallelepiped",
"Recursive Formula",
"Reduce a Fraction",
"Reduced Row-Echelon Form",
"Reference Angle",
"Reflection",
"Reflexive Property",
"Regression",
"Regression Equation",
"Regression Line",
"Regular Dodecahedron",
"Regular Hexahedron",
"Regular Icosahedron",
"Regular Octahedron",
"Regular Polygon",
"Regular Polyhedra",
"Regular Prism",
"Regular Pyramid",
"Regular Right Prism",
"Regular Right Pyramid",
"Regular Tetrahedron",
"Related Rates",
"Relation",
"Relative Maximum",
"Relative Minimum",
"Relatively Prime",
"Remainder",
"Remainder of a Series",
"Remainder Theorem",
"Removable Discontinuity",
"Residual",
"Restricted Domain",
"Restricted Function",
"Rho (Ρ ρ)",
"Rhombus",
"Riemann Sum",
"Riemannian Geometry",
"Right Angle",
"Right Circular Cone",
"Right Circular Cylinder",
"Right Cone",
"Right Cylinder",
"Right Prism",
"Right Pyramid",
"Right Regular Prism",
"Right Regular Pyramid",
"Right Square Parallelepiped",
"Right Square Prism",
"Right Triangle",
"RMS",
"Rolle's Theorem",
"Root Mean Square",
"Root of a Number",
"Root of an Equation",
"Root Rules",
"Root Test",
"Rose Curve",
"Rotation",
"Rounding a Number",
"Row of a Matrix",
"Row Operations",
"Row Reduction",
"Row-Echelon Form of a Matrix",
"Sample Space",
"Sandwich Theorem",
"Satisfy",
"Scalar",
"Scalar Product",
"Scale Factor",
"Scalene Triangle",
"Scatterplot",
"Scientific Notation",
"sec",
"Secant (Trig Function)",
"Secant Line",
"Second",
"Second Derivative",
"Second Derivative Test",
"Second Order Critical Point",
"Second Order Differential Equation",
"Sector of a Circle",
"Segment",
"Segment of a Circle",
"Self-Similarity",
"Semicircle",
"Semiperimeter",
"Separable Differential Equation",
"Sequence",
"Sequence of Partial Sums",
"Series",
"Series Rules",
"Set",
"Set Braces",
"Set Complement",
"Set Intersection",
"Set Subtraction",
"Set Union",
"Set-Builder Notation",
"Shell Method",
"Shift",
"Shrink",
"Side of a Polygon",
"Side of an Angle",
"Side of an Equation",
"Sigma (Σ σ)",
"Sigma Notation",
"Significant Digits",
"Similar",
"Similarity Tests for Triangles",
"Simple Closed Curve",
"Simple Harmonic Motion",
"Simple Interest",
"Simplify",
"Simpson's Rule",
"Simultaneous Equations",
"sin",
"Sine",
"Singular Matrix",
"Sinusoid",
"Skew Lines",
"Slant Height",
"Slope of a Curve",
"Slope of a Line",
"Slope-Intercept Equation",
"SOHCAHTOA",
"Solid",
"Solid Geometry",
"Solid of Revolution",
"Solution",
"Solution Set",
"Solve",
"Solve Analytically",
"Solve Graphically",
"Special Angles",
"Speed",
"Sphere",
"Spherical Trigonometry",
"Spheroid",
"Spiral",
"Spurious Solution",
"Square",
"Square Matrix",
"Square Root",
"Square Root Rules",
"Square System of Equations",
"Squeeze Theorem",
"Standard Form",
"Standard Position",
"Stem-and-Leaf Plot",
"Stemplot",
"Step Discontinuity",
"Step Function",
"Stewart's Theorem",
"Straight Angle",
"Stretch",
"Strict Inequality",
"Subset",
"Substitution Method",
"Subtraction of Sets",
"Sum",
"Sum Rule for Probability",
"Sum to Product Identities",
"Sum/Difference Identities",
"Superset",
"Supplement",
"Supplementary Angles",
"Surd",
"Sure Event",
"Surface",
"Surface Area",
"Surface of Revolution",
"Symmetric",
"Symmetric about the Origin",
"Symmetric about the x-axis",
"Symmetric about the y-axis",
"Symmetric across the Origin",
"Symmetric across the x-axis",
"Symmetric across the y-axis",
"Symmetric Property",
"Synthetic Division",
"Synthetic Substitution",
"System of Equations",
"System of Inequalities",
"System of Linear Equations",
"Table of Integrals",
"Takeout Angle",
"tan",
"Tangent (Trig Function)",
"Tangent Line",
"Tau (Τ τ)",
"Tautochrone",
"Taylor Polynomial",
"Taylor Series",
"Taylor Series Remainder",
"Term",
"Terminal Side of an Angle",
"Tessellate",
"Tetrahedron",
"Theorem",
"Theorem of Menelaus",
"Theorem of Pappus",
"Theta (Θ θ)",
"Third Quartile",
"Three Dimensional Coordinates",
"Three Dimensions",
"Tilted Asymptote",
"Toolkit Functions",
"Torus",
"Transcendental Numbers",
"Transformations",
"Transitive Property of Equality",
"Transitive Property of Inequalities",
"Translation",
"Transpose of a Matrix",
"Transversal",
"Trapezium",
"Trapezoid",
"Trapezoid Rule",
"Triangle",
"Triangle Congruence Tests",
"Triangle Inequality",
"Triangle Similarity Tests",
"Triangulation",
"Trichotomy",
"Trig",
"Trig Functions",
"Trig Identities",
"Trig Substitution",
"Trig Values of Special Angles",
"Trigonometry",
"Trinomial",
"Triple",
"Triple (Scalar) Product",
"Triple Root",
"Trivial",
"Truncated Cone or Pyramid",
"Truncated Cylinder or Prism",
"Truncating a Number",
"Twin Primes",
"Two Dimensions",
"u-Substitution",
"Unbounded Set of Numbers",
"Uncountable",
"Uncountably Infinite",
"Undecagon",
"Undefined Slope",
"Underdetermined",
"Uniform",
"Union",
"Unit Circle",
"Unit Circle Trig Definitions",
"Unit Vector",
"Upper Bound",
"Upper Quartile",
"Upsilon (Υ υ)",
"Variable",
"Varignon Parallelogram",
"Vector",
"Vector Calculus",
"Velocity",
"Venn Diagrams",
"Verify a Solution",
"Vertex",
"Vertex of a Hyperbola",
"Vertex of a Parabola",
"Vertex of an Ellipse",
"Vertical",
"Vertical Angles",
"Vertical Compression",
"Vertical Dilation",
"Vertical Ellipse",
"Vertical Hyperbola",
"Vertical Line Equation",
"Vertical Line Test",
"Vertical Parabola",
"Vertical Reflection",
"Vertical Shift",
"Vertical Shrink",
"Vertical Stretch",
"Vertical Translation",
"Vertices of a Hyperbola",
"Vertices of an Ellipse",
"Vinculum",
"Volume",
"Washer",
"Washer Method",
"Wavelength",
"Weighted Average",
"Whole Numbers",
"Work",
"x-intercept",
"x-y Plane",
"x-z Plane",
"Xi (Ξ ξ)",
"y-intercept",
"y-z Plane",
"z-intercept",
"Zero",
"Zero Dimensions",
"Zero Matrix",
"Zero of a Function",
"Zero Slope",
"Zero Vector",
"Zeta (Ζ ζ)"
]
  end

  def self.adjectives
[
"aback ",
"abaft ",
"abandoned ",
"abashed ",
"aberrant ",
"abhorrent ",
"abiding ",
"abject ",
"ablaze ",
"able",
"abnormal ",
"aboard ",
"aboriginal ",
"abortive ",
"abounding ",
"abrasive ",
"abrupt ",
"absent ",
"absorbed ",
"absorbing ",
"abstracted ",
"absurd ",
"abundant",
"abusive ",
"acceptable ",
"accessible ",
"accidental ",
"accurate ",
"acid",
"acidic",
"acoustic ",
"acrid ",
"actually ",
"ad hoc ",
"adamant ",
"adaptable ",
"addicted ",
"adhesive ",
"adjoining ",
"adorable ",
"adventurous",
"afraid ",
"aggressive",
"agonizing ",
"agreeable ",
"ahead ",
"ajar",
"alcoholic ",
"alert ",
"alike ",
"alive ",
"alleged ",
"alluring ",
"aloof ",
"amazing",
"ambiguous ",
"ambitious ",
"amuck ",
"amused",
"amusing",
"ancient ",
"angry ",
"animated ",
"annoyed ",
"annoying",
"anxious ",
"apathetic ",
"aquatic ",
"aromatic ",
"arrogant ",
"ashamed",
"aspiring ",
"assorted ",
"astonishing ",
"attractive",
"auspicious ",
"automatic",
"available ",
"average ",
"awake",
"aware ",
"awesome",
"awful ",
"axiomatic",
"bad ",
"barbarous ",
"bashful ",
"bawdy ",
"beautiful ",
"befitting ",
"belligerent ",
"beneficial",
"bent",
"berserk ",
"best",
"better",
"bewildered ",
"big",
"billowy ",
"bite-sized",
"bitter",
"bizarre ",
"black",
"black-and-white",
"bloody ",
"blue",
"blue-eyed ",
"blushing ",
"boiling ",
"boorish ",
"bored ",
"boring ",
"bouncy",
"boundless ",
"brainy ",
"brash ",
"brave ",
"brawny ",
"breakable ",
"breezy ",
"brief",
"bright ",
"bright ",
"broad ",
"broken ",
"brown",
"bumpy ",
"burly ",
"bustling",
"busy",
"cagey",
"calculating",
"callous ",
"calm ",
"capable ",
"capricious ",
"careful ",
"careless",
"caring",
"cautious ",
"ceaseless ",
"certain",
"changeable ",
"charming ",
"cheap",
"cheerful ",
"chemical",
"chief",
"childlike ",
"chilly ",
"chivalrous ",
"chubby ",
"chunky ",
"clammy ",
"classy ",
"clean ",
"clear ",
"clever ",
"cloistered ",
"cloudy ",
"closed",
"clumsy",
"cluttered",
"coherent ",
"cold ",
"colorful ",
"colossal ",
"combative ",
"comfortable ",
"common",
"complete",
"complex",
"concerned ",
"condemned ",
"confused ",
"conscious",
"cooing ",
"cool ",
"cooperative ",
"coordinated",
"courageous ",
"cowardly ",
"crabby ",
"craven ",
"crazy ",
"creepy ",
"crooked ",
"crowded ",
"cruel ",
"cuddly ",
"cultured ",
"cumbersome",
"curious ",
"curly ",
"curved ",
"curvy",
"cut",
"cute ",
"cute",
"cynical",
"daffy ",
"daily ",
"damaged ",
"damaging ",
"damp ",
"dangerous ",
"dapper ",
"dark ",
"dashing ",
"dazzling",
"dead ",
"deadpan ",
"deafening ",
"dear",
"debonair ",
"decisive ",
"decorous ",
"deep ",
"deeply ",
"defeated ",
"defective ",
"defiant ",
"delicate",
"delicious",
"delightful ",
"demonic ",
"delirious",
"dependent",
"depressed ",
"deranged ",
"descriptive",
"deserted",
"detailed ",
"determined ",
"devilish ",
"didactic ",
"different ",
"difficult ",
"diligent ",
"direful ",
"dirty ",
"disagreeable ",
"disastrous",
"discreet ",
"disgusted ",
"disgusting",
"disillusioned ",
"dispensable ",
"distinct ",
"disturbed ",
"divergent ",
"dizzy",
"domineering ",
"doubtful ",
"drab ",
"draconian ",
"dramatic ",
"dreary",
"drunk ",
"dry ",
"dull ",
"dusty ",
"dusty",
"dynamic ",
"dysfunctional",
"eager ",
"early",
"earsplitting ",
"earthy ",
"easy ",
"eatable ",
"economic ",
"educated ",
"efficacious ",
"efficient ",
"eight ",
"elastic",
"elated ",
"elderly",
"electric",
"elegant ",
"elfin ",
"elite ",
"embarrassed ",
"eminent ",
"empty",
"enchanted",
"enchanting ",
"encouraging ",
"endurable ",
"energetic ",
"enormous ",
"entertaining ",
"enthusiastic ",
"envious ",
"equable ",
"equal",
"erect ",
"erratic ",
"ethereal ",
"evanescent ",
"evasive ",
"even",
"excellent",
"excited ",
"exciting",
"exclusive ",
"exotic ",
"expensive ",
"extra-large",
"extra-small",
"exuberant ",
"exultant",
"fabulous ",
"faded ",
"faint",
"fair ",
"faithful ",
"fallacious ",
"famous ",
"fanatical ",
"fancy ",
"fantastic ",
"far",
"far-flung",
"fascinated ",
"fast ",
"fat",
"faulty ",
"fearful",
"fearless ",
"feeble",
"feigned ",
"female",
"fertile ",
"festive ",
"few",
"fierce ",
"filthy ",
"fine ",
"finicky ",
"first",
"five",
"fixed",
"flagrant ",
"flaky ",
"flashy ",
"flat ",
"flawless ",
"flimsy",
"flippant ",
"flowery ",
"fluffy ",
"fluttering",
"foamy ",
"foolish ",
"foregoing ",
"forgetful ",
"fortunate ",
"four",
"frail ",
"fragile ",
"frantic ",
"free",
"freezing",
"frequent",
"fresh",
"fretful ",
"friendly ",
"frightened",
"frightening",
"full",
"fumbling",
"functional ",
"funny ",
"furry",
"furtive ",
"future",
"futuristic ",
"fuzzy",
"gabby ",
"gainful ",
"gamy ",
"gaping ",
"garrulous ",
"gaudy ",
"general",
"gentle ",
"giant ",
"giddy ",
"gifted",
"gigantic ",
"glamorous ",
"gleaming ",
"glib ",
"glistening",
"glorious ",
"glossy ",
"godly ",
"good ",
"goofy ",
"gorgeous ",
"graceful ",
"grandiose ",
"grateful",
"gratis ",
"gray",
"greasy",
"great ",
"greedy ",
"green",
"grey",
"grieving ",
"groovy ",
"grotesque ",
"grouchy ",
"grubby",
"gruesome ",
"grumpy ",
"guarded ",
"guiltless ",
"gullible",
"gusty ",
"guttural",
"habitual ",
"half ",
"hallowed ",
"halting ",
"handsome ",
"handsomely ",
"handy",
"hanging",
"hapless ",
"happy ",
"hard",
"hard-to-find",
"harmonious ",
"harsh ",
"hateful",
"heady ",
"healthy ",
"heartbreaking ",
"heavenly",
"heavy",
"hellish ",
"helpful ",
"helpless ",
"hesitant ",
"hideous",
"high ",
"highfalutin ",
"high-pitched ",
"hilarious ",
"hissing ",
"historical ",
"holistic ",
"hollow ",
"homeless ",
"homely ",
"honorable ",
"horrible ",
"hospitable ",
"hot",
"huge ",
"hulking ",
"humdrum ",
"humorous ",
"hungry ",
"hurried ",
"hurt ",
"hushed ",
"husky ",
"hypnotic ",
"hysterical",
"icky ",
"icy",
"idiotic ",
"ignorant",
"ill ",
"illegal ",
"ill-fated",
"ill-informed",
"illustrious ",
"imaginary ",
"immense",
"imminent ",
"impartial ",
"imperfect ",
"impolite",
"important ",
"imported ",
"impossible ",
"incandescent ",
"incompetent ",
"inconclusive ",
"industrious ",
"incredible",
"inexpensive",
"infamous",
"innate ",
"innocent ",
"inquisitive ",
"insidious",
"instinctive ",
"intelligent",
"interesting",
"internal ",
"invincible ",
"irate ",
"irritating",
"itchy",
"jaded ",
"jagged ",
"jazzy ",
"jealous ",
"jittery ",
"jobless ",
"jolly ",
"joyous ",
"judicious ",
"juicy",
"jumbled ",
"jumpy",
"juvenile",
"kaput ",
"keen",
"kind ",
"kindhearted ",
"kindly",
"knotty ",
"knowing ",
"knowledgeable ",
"known",
"labored ",
"lackadaisical ",
"lacking ",
"lame",
"lamentable ",
"languid ",
"large",
"last",
"late",
"laughable ",
"lavish ",
"lazy",
"lean",
"learned ",
"left",
"legal ",
"lethal ",
"level ",
"lewd ",
"light ",
"like",
"likeable ",
"limping",
"literate ",
"little ",
"lively ",
"lively ",
"living",
"lonely ",
"long",
"longing ",
"long-term",
"loose",
"lopsided ",
"loud ",
"loutish ",
"lovely ",
"loving",
"low ",
"lowly ",
"lucky ",
"ludicrous ",
"lumpy",
"lush ",
"luxuriant ",
"lying ",
"lyrical",
"macabre ",
"macho ",
"maddening ",
"madly ",
"magenta",
"magical ",
"magnificent",
"majestic ",
"makeshift ",
"male",
"malicious ",
"mammoth ",
"maniacal ",
"many",
"marked ",
"massive ",
"married",
"marvelous",
"material",
"materialistic ",
"mature ",
"mean ",
"measly ",
"meaty",
"medical",
"meek",
"mellow",
"melodic ",
"melted",
"merciful ",
"mere ",
"messy",
"mighty",
"military",
"milky",
"mindless ",
"miniature ",
"minor ",
"miscreant ",
"misty ",
"mixed",
"moaning ",
"modern ",
"moldy ",
"momentous ",
"motionless ",
"mountainous",
"muddled ",
"mundane",
"murky",
"mushy",
"mute ",
"mysterious",
"naive ",
"nappy ",
"narrow ",
"nasty ",
"natural",
"naughty ",
"nauseating ",
"near",
"neat",
"nebulous ",
"necessary",
"needless ",
"needy ",
"neighborly ",
"nervous ",
"new ",
"next",
"nice",
"nifty ",
"nimble",
"nine",
"nippy",
"noiseless ",
"noisy ",
"nonchalant ",
"nondescript ",
"nonstop ",
"normal",
"nostalgic ",
"nosy",
"noxious ",
"null ",
"numberless ",
"numerous",
"nutritious ",
"nutty",
"oafish ",
"obedient ",
"obeisant ",
"obese",
"obnoxious ",
"obscene ",
"obsequious ",
"observant ",
"obsolete ",
"obtainable ",
"oceanic ",
"odd",
"offbeat ",
"old",
"old-fashioned",
"omniscient ",
"one ",
"onerous ",
"open ",
"opposite",
"optimal ",
"orange",
"ordinary",
"organic ",
"ossified ",
"outgoing",
"outrageous ",
"outstanding ",
"oval ",
"overconfident ",
"overjoyed ",
"overrated ",
"overt ",
"overwrought",
"painful ",
"painstaking ",
"pale",
"paltry",
"panicky ",
"panoramic ",
"parallel",
"parched ",
"parsimonious ",
"past",
"pastoral ",
"pathetic ",
"peaceful ",
"penitent ",
"perfect ",
"periodic ",
"permissible ",
"perpetual ",
"petite ",
"petite ",
"phobic ",
"physical",
"picayune",
"pink ",
"piquant ",
"placid ",
"plain ",
"plant ",
"plastic",
"plausible ",
"pleasant ",
"plucky ",
"pointless ",
"poised ",
"polite",
"political ",
"poor",
"possessive ",
"possible",
"powerful",
"precious ",
"premium ",
"present",
"pretty ",
"previous",
"pricey",
"prickly ",
"private",
"probable ",
"productive ",
"profuse ",
"protective ",
"proud ",
"psychedelic ",
"psychotic ",
"public",
"puffy ",
"pumped ",
"puny ",
"purple ",
"purring ",
"pushy",
"puzzled",
"puzzling",
"quack ",
"quaint ",
"quarrelsome ",
"questionable ",
"quick",
"quickest",
"quiet",
"quirky",
"quixotic ",
"quizzical ",
"rabid ",
"racial ",
"ragged ",
"rainy",
"rambunctious ",
"rampant ",
"rapid",
"rare",
"raspy ",
"ratty ",
"ready",
"real ",
"rebel ",
"receptive ",
"recondite ",
"red",
"redundant ",
"reflective ",
"regular",
"relieved ",
"remarkable",
"reminiscent ",
"repulsive ",
"resolute ",
"resonant ",
"responsible",
"rhetorical ",
"rich",
"right",
"righteous ",
"rightful ",
"rigid",
"ripe",
"ritzy ",
"roasted ",
"robust ",
"romantic ",
"roomy ",
"rotten",
"rough",
"round ",
"royal ",
"ruddy ",
"rude",
"rural ",
"rustic ",
"ruthless",
"sable ",
"sad",
"safe",
"salty",
"same",
"sassy ",
"satisfying ",
"savory ",
"scandalous ",
"scarce ",
"scared",
"scary ",
"scattered",
"scientific ",
"scintillating ",
"scrawny",
"screeching ",
"second",
"second-hand",
"secret",
"secretive ",
"sedate ",
"seemly ",
"selective ",
"selfish ",
"separate",
"serious",
"shaggy",
"shaky",
"shallow ",
"sharp",
"shiny",
"shivering",
"shocking ",
"short ",
"shrill ",
"shut",
"shy ",
"sick",
"silent ",
"silent",
"silky",
"silly ",
"simple",
"simplistic",
"sincere ",
"six ",
"skillful ",
"skinny ",
"sleepy ",
"slim",
"slimy",
"slippery",
"sloppy ",
"slow",
"small",
"smart",
"smelly ",
"smiling ",
"smoggy ",
"smooth",
"sneaky ",
"snobbish ",
"snotty ",
"soft ",
"soggy ",
"solid",
"somber ",
"sophisticated",
"sordid ",
"sore ",
"sore",
"sour",
"sparkling ",
"special",
"spectacular ",
"spicy",
"spiffy",
"spiky",
"spiritual ",
"spiteful",
"splendid ",
"spooky ",
"spotless ",
"spotted",
"spotty",
"spurious ",
"squalid ",
"square ",
"squealing ",
"squeamish ",
"staking ",
"stale",
"standing ",
"statuesque ",
"steadfast ",
"steady",
"steep ",
"stereotyped ",
"sticky",
"stiff",
"stimulating ",
"stingy",
"stormy",
"straight ",
"strange ",
"striped",
"strong",
"stupendous",
"stupid ",
"sturdy",
"subdued ",
"subsequent ",
"substantial",
"successful ",
"succinct ",
"sudden",
"sulky ",
"super ",
"superb",
"superficial",
"supreme ",
"swanky ",
"sweet",
"sweltering ",
"swift",
"symptomatic ",
"synonymous ",
"taboo ",
"tacit ",
"tacky ",
"talented",
"tall",
"tame ",
"tan",
"tangible ",
"tangy ",
"tart",
"tasteful ",
"tasteless",
"tasty",
"tawdry ",
"tearful ",
"tedious",
"teeny",
"teeny-tiny",
"telling ",
"temporary ",
"ten ",
"tender",
"tense ",
"tense",
"tenuous ",
"terrible ",
"terrific",
"tested ",
"testy",
"thankful",
"therapeutic ",
"thick",
"thin",
"thinkable ",
"third",
"thirsty",
"thirsty",
"thoughtful ",
"thoughtless ",
"threatening",
"three ",
"thundering ",
"tidy",
"tight ",
"tightfisted ",
"tiny",
"tired ",
"tiresome ",
"toothsome ",
"torpid ",
"tough",
"towering ",
"tranquil ",
"trashy ",
"tremendous",
"tricky",
"trite ",
"troubled ",
"truculent ",
"truthful",
"two",
"typical",
"ubiquitous ",
"ugliest",
"ugly ",
"ultra ",
"unable ",
"unaccountable ",
"unadvised ",
"unarmed ",
"unbecoming ",
"unbiased ",
"uncovered ",
"understood ",
"undesirable ",
"unequal",
"unequaled ",
"uneven",
"unhealthy",
"uninterested ",
"unique",
"unkempt",
"unknown",
"unnatural",
"unruly",
"unsightly ",
"unsuitable ",
"untidy",
"unused",
"unusual ",
"unwieldy",
"unwritten",
"upbeat ",
"uppity ",
"upset ",
"uptight ",
"used ",
"useful",
"useless",
"utopian ",
"utter ",
"uttermost ",
"vacuous ",
"vagabond ",
"vague ",
"valuable",
"various ",
"vast",
"vengeful ",
"venomous ",
"verdant ",
"versed ",
"victorious ",
"vigorous ",
"violent",
"violet",
"vivacious ",
"voiceless ",
"volatile ",
"voracious ",
"vulgar",
"wacky ",
"waggish ",
"waiting",
"wakeful ",
"wandering ",
"wanting ",
"warlike ",
"warm",
"wary ",
"wasteful ",
"watery",
"weak",
"wealthy",
"weary ",
"well-groomed",
"well-made",
"well-off",
"well-to-do",
"wet",
"whimsical ",
"whispering ",
"white",
"whole",
"wholesale ",
"wicked ",
"wide ",
"wide-eyed",
"wiggly",
"wild ",
"willing ",
"windy",
"wiry ",
"wise ",
"wistful ",
"witty ",
"woebegone ",
"womanly ",
"wonderful ",
"wooden",
"woozy ",
"workable ",
"worried ",
"worthless ",
"wrathful ",
"wretched ",
"wrong",
"wry ",
"xenophobic",
"yellow ",
"yielding ",
"young",
"youthful ",
"yummy",
"zany ",
"zealous ",
"zesty",
"zippy ",
"zonked"
]
  end
end
