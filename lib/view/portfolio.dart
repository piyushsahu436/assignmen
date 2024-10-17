import 'package:flutter/material.dart';
import '../controller/portfolio_controller.dart';
import '../model/project_model.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final PortfolioController _controller = PortfolioController();
  List<Project> allProjects = []; // Store all projects
  List<Project> filteredProjects = []; // Store filtered projects
  String searchQuery = ""; // To track the search input

  @override
  void initState() {
    super.initState();
    allProjects = _controller.getProjects(); // Initialize all projects
    filteredProjects = allProjects; // Initially, all projects are shown
  }

  // This function will filter the projects based on the search query
  void filterProjects(String query) {
    List<Project> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = allProjects
          .where((project) =>
          project.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredList = allProjects; // Show all projects if query is empty
    }
    setState(() {
      searchQuery = query;
      filteredProjects = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs in the TabBar
      child: Scaffold(
        appBar: AppBar(
          title: Text('Portfolio'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.work,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Project'),
              Tab(text: 'Saved'),
              Tab(text: 'Shared'),
              Tab(text: 'Achievement'),
            ],
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.orange,
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                // "Project" tab content: Shows the search bar and filtered project list
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        onChanged: (value) => filterProjects(value), // Call the filter function on input change
                        decoration: InputDecoration(
                          hintText: 'Search a project',
                          suffixIcon: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Icon(Icons.search, color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredProjects.length, // Show filtered projects
                        itemBuilder: (context, index) {
                          return ProjectCard(project: filteredProjects[index]);
                        },
                      ),
                    ),
                  ],
                ),
                // "Saved" tab: Empty container
                Center(
                  child: Container(), // Empty content for the "Saved" tab
                ),
                // "Shared" tab: Empty container
                Center(
                  child: Container(), // Empty content for the "Shared" tab
                ),
                // "Achievement" tab: Empty container
                Center(
                  child: Container(), // Empty content for the "Achievement" tab
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter, // Align the button at the bottom center
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Add filter logic here
                  },
                  icon: Icon(Icons.filter_alt,
                      color: Colors.white, size: 24.0),
                  label: Text(
                    "Filter",

                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(project.imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(project.subtitle),
                  Text(
                    'Oleh ${project.author}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                project.grade,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
