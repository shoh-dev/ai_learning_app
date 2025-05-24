// supabase/functions/plan-generator/mock_debug.ts
// ------------------------------------------------------------------
// Hard-coded example that mirrors the live response you pasted.
// Toggle `isDebugMode = true` in index.ts to use this without Gemini.
// ------------------------------------------------------------------

import { PlanResponse } from "./types.ts";

export const MOCK_PLAN: PlanResponse = {
  topic: "Python Programming",
  mode: "milestones",
  milestones: [
    {
      title: "Setting Up Your Environment",
      description:
        "Install Python and a code editor to start writing and running Python code.",
      resource_url: "https://www.python.org/downloads/",
      substeps: [
        {
          title: "Install Python",
          detail_url: "https://realpython.com/installing-python/",
          download_url: null,
          action_hint: {
            icon: "download",
            value: "Download and install the latest version of Python.",
          },
          estimated_minutes: 15,
        },
        {
          title: "Choose a Code Editor",
          detail_url: "https://realpython.com/python-ides-code-editors-guide/",
          download_url: null,
          action_hint: {
            icon: "keyboard_alt",
            value:
              "Select a code editor (e.g., VS Code, Sublime Text, PyCharm).",
          },
          estimated_minutes: 10,
        },
        {
          title: "Install the Editor",
          detail_url: null,
          download_url: null,
          action_hint: {
            icon: "download",
            value: "Install your chosen editor",
          },
          estimated_minutes: 15,
        },
      ],
      quiz: {
        question: "Which of the following is NOT a popular Python code editor?",
        choices: ["VS Code", "Sublime Text", "Notepad", "PyCharm"],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- Basic Syntax ---------- */
    {
      title: "Basic Syntax and Data Types",
      description:
        "Learn about variables, data types (integers, floats, strings, booleans), and basic operations.",
      resource_url: "https://www.w3schools.com/python/python_datatypes.asp",
      substeps: [
        {
          title: "Variables and Assignment",
          detail_url: "https://www.w3schools.com/python/python_variables.asp",
          download_url: null,
          estimated_minutes: 20,
        },
        {
          title: "Data Types",
          detail_url: "https://www.w3schools.com/python/python_datatypes.asp",
          download_url: null,
          estimated_minutes: 25,
        },
        {
          title: "Basic Operators",
          detail_url: "https://www.w3schools.com/python/python_operators.asp",
          download_url: null,
          estimated_minutes: 20,
        },
      ],
      quiz: {
        question:
          "What data type is used to represent whole numbers in Python?",
        choices: ["float", "string", "int", "boolean"],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- Control Flow ---------- */
    {
      title: "Control Flow: Conditionals and Loops",
      description:
        "Understand how to control the flow of your program using if/else statements and loops (for and while).",
      resource_url: "https://www.w3schools.com/python/python_if_else.asp",
      substeps: [
        {
          title: "If/Else Statements",
          detail_url: "https://www.w3schools.com/python/python_if_else.asp",
          download_url: null,
          estimated_minutes: 30,
        },
        {
          title: "For Loops",
          detail_url: "https://www.w3schools.com/python/python_for_loops.asp",
          download_url: null,
          estimated_minutes: 25,
        },
        {
          title: "While Loops",
          detail_url: "https://www.w3schools.com/python/python_while_loops.asp",
          download_url: null,
          estimated_minutes: 25,
        },
      ],
      quiz: {
        question: "Which keyword is used to start an if statement in Python?",
        choices: ["elseif", "if", "when", "condition"],
        correct_answer_index: 1,
      },
      can_generate_image: false,
    },

    /* ---------- Functions ---------- */
    {
      title: "Functions",
      description:
        "Learn how to define and use functions to organize and reuse code.",
      resource_url: "https://www.w3schools.com/python/python_functions.asp",
      substeps: [
        {
          title: "Defining Functions",
          detail_url: "https://www.w3schools.com/python/python_functions.asp",
          download_url: null,
          estimated_minutes: 30,
        },
        {
          title: "Calling Functions",
          detail_url: null,
          download_url: null,
          estimated_minutes: 20,
        },
        {
          title: "Function Arguments and Return Values",
          detail_url: null,
          download_url: null,
          estimated_minutes: 25,
        },
      ],
      quiz: {
        question: "Which keyword is used to define a function in Python?",
        choices: ["define", "function", "def", "fun"],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- Data Structures ---------- */
    {
      title: "Data Structures: Lists and Dictionaries",
      description:
        "Explore fundamental data structures for storing collections of data.",
      resource_url: "https://www.w3schools.com/python/python_lists.asp",
      substeps: [
        {
          title: "Lists",
          detail_url: "https://www.w3schools.com/python/python_lists.asp",
          download_url: null,
          estimated_minutes: 35,
        },
        {
          title: "Dictionaries",
          detail_url:
            "https://www.w3schools.com/python/python_dictionaries.asp",
          download_url: null,
          estimated_minutes: 35,
        },
        {
          title: "List and Dictionary Operations",
          detail_url: null,
          download_url: null,
          estimated_minutes: 20,
        },
      ],
      quiz: {
        question: "Which data structure uses key-value pairs?",
        choices: ["List", "Tuple", "Dictionary", "Set"],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- Working with Files ---------- */
    {
      title: "Working with Files",
      description: "Learn how to read from and write to files.",
      resource_url: "https://www.w3schools.com/python/python_file_write.asp",
      substeps: [
        {
          title: "Reading Files",
          detail_url: "https://www.w3schools.com/python/python_file_read.asp",
          download_url: null,
          estimated_minutes: 30,
        },
        {
          title: "Writing to Files",
          detail_url: "https://www.w3schools.com/python/python_file_write.asp",
          download_url: null,
          estimated_minutes: 30,
        },
        {
          title: "File Modes",
          detail_url: null,
          download_url: null,
          estimated_minutes: 20,
        },
      ],
      quiz: {
        question: "Which mode is used to open a file for writing?",
        choices: ["r", "w", "a", "x"],
        correct_answer_index: 1,
      },
      can_generate_image: false,
    },

    /* ---------- Modules & Packages ---------- */
    {
      title: "Introduction to Modules and Packages",
      description:
        "Learn how to use and create modules and packages to organize your code.",
      resource_url: "https://realpython.com/python-modules-packages/",
      substeps: [
        {
          title: "Importing Modules",
          detail_url: "https://realpython.com/python-modules-packages/",
          download_url: null,
          estimated_minutes: 35,
        },
        {
          title: "Creating Modules",
          detail_url: null,
          download_url: null,
          estimated_minutes: 30,
        },
        {
          title: "Packages",
          detail_url: null,
          download_url: null,
          estimated_minutes: 25,
        },
      ],
      quiz: {
        question: "Which keyword is used to import a module in Python?",
        choices: ["include", "require", "import", "using"],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- OOP ---------- */
    {
      title: "Object-Oriented Programming (OOP)",
      description:
        "Understand the basics of classes, objects, inheritance, and polymorphism.",
      resource_url:
        "https://realpython.com/python3-object-oriented-programming/",
      substeps: [
        {
          title: "Classes and Objects",
          detail_url:
            "https://realpython.com/python3-object-oriented-programming/",
          download_url: null,
          estimated_minutes: 40,
        },
        {
          title: "Inheritance",
          detail_url: null,
          download_url: null,
          estimated_minutes: 35,
        },
        {
          title: "Polymorphism",
          detail_url: null,
          download_url: null,
          estimated_minutes: 35,
        },
      ],
      quiz: {
        question: "What is the term for creating an instance of a class?",
        choices: [
          "Inheritance",
          "Polymorphism",
          "Instantiation",
          "Abstraction",
        ],
        correct_answer_index: 2,
      },
      can_generate_image: false,
    },

    /* ---------- APIs ---------- */
    {
      title: "Working with APIs",
      description: "Learn how to retrieve data from the web using APIs.",
      resource_url: "https://realpython.com/api-integration-in-python/",
      substeps: [
        {
          title: "Making API Requests",
          detail_url: "https://realpython.com/api-integration-in-python/",
          download_url: null,
          estimated_minutes: 45,
        },
        {
          title: "Handling API Responses",
          detail_url: null,
          download_url: null,
          estimated_minutes: 40,
        },
        {
          title: "Parsing JSON Data",
          detail_url: null,
          download_url: null,
          estimated_minutes: 35,
        },
      ],
      quiz: {
        question:
          "Which library is commonly used to make HTTP requests in Python?",
        choices: ["socket", "requests", "urllib", "http"],
        correct_answer_index: 1,
      },
      can_generate_image: false,
    },

    /* ---------- Matplotlib ---------- */
    {
      title: "Creating Visualizations with Matplotlib",
      description:
        "Learn how to create basic plots and charts using Matplotlib.",
      resource_url: "https://matplotlib.org/stable/tutorials/index.html",
      substeps: [
        {
          title: "Installing Matplotlib",
          detail_url: null,
          download_url: null,
          action_hint: { icon: "terminal", value: "pip install matplotlib" },
          estimated_minutes: 10,
        },
        {
          title: "Basic Plots",
          detail_url:
            "https://matplotlib.org/stable/tutorials/introductory/pyplot.html",
          download_url: null,
          estimated_minutes: 40,
        },
        {
          title: "Customizing Plots",
          detail_url: null,
          download_url: null,
          estimated_minutes: 40,
        },
      ],
      quiz: {
        question: "Which function is used to display a plot in Matplotlib?",
        choices: ["show()", "display()", "plot()", "render()"],
        correct_answer_index: 0,
      },
      can_generate_image: true,
    },
  ],
};

// {"topic":"Uzbek Pilaf (Osh) Cooking","mode":"milestones","milestones":[{"title":"Understanding the Basics of Uzbek Pilaf","description":"Learn about the history, regional variations, and key ingredients that define authentic Uzbek Pilaf (Osh).","resource_url":"https://www.allrecipes.com/recipe/213258/authentic-uzbek-pilaf/","substeps":[{"title":"Research the history and cultural significance of Uzbek Pilaf.","detail_url":null,"download_url":null,"estimated_minutes":15},{"title":"Identify the core ingredients: rice, meat (usually lamb or beef), carrots, onions, oil, and spices.","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Explore regional variations in ingredients and cooking methods.","detail_url":null,"download_url":null,"estimated_minutes":10}],"quiz":{"question":"Which ingredient is NOT traditionally used in Uzbek Pilaf?","choices":["Rice","Lamb","Carrots","Potatoes"],"correct_answer_index":3},"can_generate_image":false},{"title":"Gathering the Right Ingredients","description":"Source high-quality ingredients, focusing on the specific type of rice and meat suitable for Pilaf.","resource_url":null,"substeps":[{"title":"Select the right type of rice (e.g., Devzira, Arborio, or Calrose).","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Choose the appropriate cut of meat (lamb shoulder or beef chuck are good options).","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Find fresh carrots (yellow carrots are preferred, if available) and onions.","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Assemble the necessary spices: cumin, coriander, barberries, and salt.","detail_url":null,"download_url":null,"estimated_minutes":5}],"quiz":{"question":"Which type of rice is traditionally preferred for Uzbek Pilaf?","choices":["Basmati","Jasmine","Devzira","Sushi Rice"],"correct_answer_index":2},"can_generate_image":false},{"title":"Preparing the Ingredients","description":"Properly prepare each ingredient by washing the rice, cutting the meat and vegetables, and measuring the spices.","resource_url":null,"substeps":[{"title":"Wash the rice thoroughly until the water runs clear. Soak the rice for at least 30 minutes.","detail_url":null,"download_url":null,"action_hint":{"icon":"timer","value":"30 min"},"estimated_minutes":35},{"title":"Cut the meat into 1-inch cubes.","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Slice the carrots into matchsticks (julienne).","detail_url":null,"download_url":null,"estimated_minutes":15},{"title":"Dice the onions.","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Measure out the spices.","detail_url":null,"download_url":null,"estimated_minutes":5}],"can_generate_image":false},{"title":"Cooking the Zirvak (Base)","description":"Master the technique of creating the 'zirvak,' the flavorful base of the pilaf, by browning the meat and caramelizing the vegetables.","resource_url":null,"substeps":[{"title":"Heat oil in a heavy-bottomed pot or kazan over medium-high heat.","detail_url":null,"download_url":null,"estimated_minutes":2},{"title":"Brown the meat in batches, ensuring not to overcrowd the pot.","detail_url":null,"download_url":null,"estimated_minutes":15},{"title":"Add the onions and cook until golden brown.","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Add the carrots and cook until softened and slightly caramelized.","detail_url":null,"download_url":null,"estimated_minutes":15},{"title":"Add the spices and salt, and cook for another minute.","detail_url":null,"download_url":null,"estimated_minutes":1}],"can_generate_image":true},{"title":"Layering and Simmering","description":"Properly layer the rice over the zirvak and simmer the pilaf until the rice is cooked through and the liquid is absorbed.","resource_url":null,"substeps":[{"title":"Gently layer the rice over the zirvak, spreading it evenly.","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Pour hot water over the rice to cover it by about 1 inch.","detail_url":null,"download_url":null,"estimated_minutes":2},{"title":"Bring to a boil, then reduce heat to low, cover, and simmer for 20-25 minutes, or until the rice is cooked and the liquid is absorbed.","detail_url":null,"download_url":null,"action_hint":{"icon":"timer","value":"20-25 min"},"estimated_minutes":25}],"can_generate_image":true},{"title":"Resting and Serving","description":"Allow the pilaf to rest before serving to allow the flavors to meld and the rice to fully absorb any remaining moisture.","resource_url":null,"substeps":[{"title":"Turn off the heat and let the pilaf rest, covered, for 10-15 minutes.","detail_url":null,"download_url":null,"action_hint":{"icon":"timer","value":"10-15 min"},"estimated_minutes":15},{"title":"Fluff the rice gently with a fork before serving.","detail_url":null,"download_url":null,"estimated_minutes":2},{"title":"Serve hot, garnished with fresh herbs (optional).","detail_url":null,"download_url":null,"estimated_minutes":3}],"can_generate_image":true},{"title":"Troubleshooting Common Issues","description":"Learn how to address common problems like mushy rice, burnt bottom, or undercooked meat.","resource_url":null,"substeps":[{"title":"Understand the causes of mushy rice and how to prevent it (e.g., using the correct rice-to-water ratio).","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Learn how to prevent the bottom from burning (e.g., using a heavy-bottomed pot and maintaining low heat).","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Understand how to ensure the meat is fully cooked (e.g., browning it properly and simmering for the correct amount of time).","detail_url":null,"download_url":null,"estimated_minutes":10}],"can_generate_image":false},{"title":"Experimenting with Variations","description":"Explore different variations of Uzbek Pilaf, such as using different meats, vegetables, or spices.","resource_url":null,"substeps":[{"title":"Try using beef or chicken instead of lamb.","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Experiment with adding different vegetables, such as chickpeas or garlic.","detail_url":null,"download_url":null,"estimated_minutes":5},{"title":"Adjust the spice levels to your preference.","detail_url":null,"download_url":null,"estimated_minutes":5}],"can_generate_image":true},{"title":"Mastering the Kazan Technique","description":"Dive deeper into using a traditional kazan (cauldron) for optimal Pilaf cooking.","resource_url":null,"substeps":[{"title":"Research the benefits of using a kazan for Pilaf.","detail_url":null,"download_url":null,"estimated_minutes":10},{"title":"Learn how to properly season and maintain a kazan.","detail_url":null,"download_url":null,"action_hint":{"icon":"build","value":"Seasoning"},"estimated_minutes":15},{"title":"Practice cooking Pilaf in a kazan to develop your technique.","detail_url":null,"download_url":null,"estimated_minutes":60}],"can_generate_image":true}]}

// {
//     "topic": "Cooking Russian Borsh",
//     "mode": "milestones",
//     "milestones": [
//         {
//             "title": "Understanding Borsh Basics",
//             "description": "Learn about the key ingredients and variations of borsh.",
//             "resource_url": "https://natashaskitchen.com/classic-russian-borscht-recipe/",
//             "substeps": [
//                 {
//                     "title": "Identify Core Ingredients",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 },
//                 {
//                     "title": "Explore Regional Variations",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 }
//             ],
//             "quiz": {
//                 "question": "Which ingredient is essential for the characteristic red color of borsh?",
//                 "choices": [
//                     "Carrots",
//                     "Beets",
//                     "Cabbage",
//                     "Potatoes"
//                 ],
//                 "correct_answer_index": 1
//             },
//             "can_generate_image": false
//         },
//         {
//             "title": "Preparing the Vegetables",
//             "description": "Learn how to properly prepare the vegetables for borsh.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Chopping and Slicing Techniques",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 15,
//                     "action_hint": {
//                         "icon": "build",
//                         "value": "Knife skills"
//                     }
//                 },
//                 {
//                     "title": "Preparing Beets to Retain Color",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Making the Broth",
//             "description": "Create a flavorful broth as the foundation for your borsh.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Choosing Broth Type (Beef, Chicken, or Vegetable)",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 },
//                 {
//                     "title": "Simmering the Broth",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 60,
//                     "action_hint": {
//                         "icon": "timer",
//                         "value": "Simmer"
//                     }
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Sautéing the Vegetables",
//             "description": "Sauté the vegetables to enhance their flavor before adding them to the broth.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Onion and Garlic Sauté",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 },
//                 {
//                     "title": "Adding Carrots and Beets",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Combining Ingredients and Simmering",
//             "description": "Combine the sautéed vegetables with the broth and simmer to develop the flavors.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Adding Cabbage and Potatoes",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 },
//                 {
//                     "title": "Simmering for Flavor Development",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 30,
//                     "action_hint": {
//                         "icon": "timer",
//                         "value": "Simmer"
//                     }
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Adjusting Flavor and Adding Final Touches",
//             "description": "Adjust the seasoning and add final touches like vinegar or lemon juice to balance the flavors.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Adding Vinegar or Lemon Juice",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 },
//                 {
//                     "title": "Seasoning with Salt and Pepper",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Serving and Garnishing",
//             "description": "Serve your borsh hot with a dollop of sour cream and fresh dill.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Plating and Presentation",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 },
//                 {
//                     "title": "Garnishing with Sour Cream and Dill",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 }
//             ],
//             "can_generate_image": true
//         },
//         {
//             "title": "Variations: Meat vs. Vegetarian Borsh",
//             "description": "Explore making borsh with or without meat.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Adapting the Recipe for Vegetarian Borsh",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 },
//                 {
//                     "title": "Using Different Meats in Borsh",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 10
//                 }
//             ],
//             "can_generate_image": false
//         },
//         {
//             "title": "Storing and Reheating Borsh",
//             "description": "Learn how to properly store and reheat borsh for optimal flavor.",
//             "resource_url": null,
//             "substeps": [
//                 {
//                     "title": "Proper Storage Techniques",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 },
//                 {
//                     "title": "Reheating Methods",
//                     "detail_url": null,
//                     "download_url": null,
//                     "estimated_minutes": 5
//                 }
//             ],
//             "can_generate_image": false
//         }
//     ]
// }
