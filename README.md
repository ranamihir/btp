# B. Tech. Project: Data Driven Modelling of Composites

# Project objective
<br>
To develop an algorithmic framework to predict properties of composites to aid in meta-modelling process. 
<br>
<br>

<h2>Introduction to Composites</h2>
Composites are made by combining two or more natural or artificial materials to maximize their useful properties and minimize their weaknesses. One of the oldest and best-known composites, glass-fiber reinforced plastic (GRP), combines glass fibers (which are strong but brittle) with plastic (which is flexible) to make a composite material that is tough but not brittle. Composites are typically used in place of metals because they are equally strong but much lighter.
<br>
<br>
<h2>Applications</h2>
<h3>Airbus A380</h3>
More than 20 % of the A380 is made of composite materials, mainly plastic reinforced with carbon fibres. The design is the first large-scale use of glass-fibre-reinforced aluminium, a new composite that is 25 % stronger than conventional airframe aluminium but 20 % lighter.
<h3>Concrete</h3>
Concrete is a versatile and cheap material, with a vast range of applications around the home. Brick laying, constructing paths and driveways, foundations to buildings and walls, are some of the practical applications. Concrete has a similarly wide and varied range in industrial applications.
<h3>Wind Turbine</h3>
Currently, carbon fiber is used primarily in the spar, or structural element, of wind blades longer than 45m/148 ft, both for land-based and offshore systems. The higher stiffness and lower density of CF allows a thinner blade profile while producing stiffer, lighter blades.
<br>
<br>
<h2>Challenges</h2>
Since precise material properties are often needed to satisfy industrial needs and criteria, design of composites with tailored properties is of utmost importance.
<br>
The design and analysis of such composites faces following challenges -
<br>
<ul>
<li>Computational Expense</li>
<li>Heavy Simulations</li>
<li>Rigorous Experimentation</li>
<li>Time Expensive Process</li>
</ul>

<br>
<h2>Behaviour of Composites</h2>
Macroscopic mechanical behavior originates from mechanics of underlying microstructure.
<br>
<br>
Key mechanical performances of materials:
<ul>
<li>Elastic moduli</li>
<li>Toughness</li>
<li>Ductility</li>
<li>Fracture resistance</li>
<li>Hardness</li>
</ul>
<br>
Microstructural parameters that influence the macroscopic behaviors:
<br>
<ul>
<li>Shape (Assumed circular in our analysis)</li>
<li>Size</li>
<li>Spatial arrangement</li>
<li>Volume fraction and properties of constituents of the microstructure</li>
</ul>
<br>
<h2>Why Data Driven?</h2>
<ul>
<li>Traditional methods like ‘Rule of Mixture’ and ‘Micromechanics’ Theories cannot be applied for extremely non-linear materials (like that in Tyres), and the distribution of particles.</li>
<li>Simulations are relatively more complicated. The methodology developed requires more effort as compared to Machine Learning based approaches.</li>
<li>Simulations are also computationally expensive, especially when being done for a huge range of materials with variations in all properties for each material.</li>
<li>Data driven models are computationally much cheaper, and easier to develop.</li>
<li>These models rely on data, which is already available in most laboratories sitting idle. We can make use of this past data to make accurate future predictions.</li>
<li>These models attain nearly the same (if not higher) degree of accuracy as compared to direct FE simulations.</li>
</ul>
<br>
<h2>Methodology</h2>
<ul>
<li>FE Model development for simulation of mechanical behaviour of particulate composites.</li>
<li>Create input database based on several mechanical properties, like Young’s Modulus, Poisson’s Ratio, Volume Fraction, spatial arrangements of particles, etc.</li>
<li>Perform simulations and extract stress-strain behaviour for several cases.</li>
<li>Create a meta-model using Machine Learning algorithms.</li>
<li>Generate composites with unknown material properties.</li>
<li>Predict with meta-model, and validate the results with direct FE simulations.</li>
</ul>
