import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart' as app_user;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  String _errorMessage = '';
  
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }
  
  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final users = await authProvider.getAllUsers();
      
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }
  
  void _showUserActionMenu(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(user['name'] ?? 'Unknown'),
              subtitle: Text(user['email'] ?? ''),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.upgrade),
              title: const Text('Change Membership'),
              onTap: () {
                Navigator.pop(context);
                _showChangeMembershipDialog(user);
              },
            ),
            if (!(user['isAdmin'] ?? false))
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Make Admin'),
                onTap: () {
                  Navigator.pop(context);
                  _makeUserAdmin(user['id']);
                },
              ),
          ],
        ),
      ),
    );
  }
  
  void _showChangeMembershipDialog(Map<String, dynamic> user) {
    final currentTier = user['tier'] == 'pro' 
        ? app_user.MembershipTier.pro 
        : app_user.MembershipTier.standard;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Membership'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User: ${user['name']}'),
            const SizedBox(height: 8),
            Text('Current tier: ${currentTier == app_user.MembershipTier.pro ? 'PRO' : 'Standard'}'),
            const SizedBox(height: 16),
            const Text('Select new membership tier:'),
            const SizedBox(height: 8),
            ListTile(
              title: const Text('Standard'),
              leading: Radio<app_user.MembershipTier>(
                value: app_user.MembershipTier.standard,
                groupValue: currentTier,
                onChanged: (value) {
                  Navigator.pop(context);
                  _updateUserTier(user['id'], app_user.MembershipTier.standard);
                },
              ),
            ),
            ListTile(
              title: const Text('PRO'),
              leading: Radio<app_user.MembershipTier>(
                value: app_user.MembershipTier.pro,
                groupValue: currentTier,
                onChanged: (value) {
                  Navigator.pop(context);
                  _updateUserTier(user['id'], app_user.MembershipTier.pro);
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _updateUserTier(String userId, app_user.MembershipTier tier) async {
    try {
      // Show loading indicator
      _showLoadingDialog();
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.updateUserTier(userId, tier);
      
      // Remove loading indicator
      if (mounted) Navigator.pop(context);
      
      // Refresh user list
      await _loadUsers();
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Membership updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Remove loading indicator
      if (mounted) Navigator.pop(context);
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update membership: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  Future<void> _makeUserAdmin(String userId) async {
    try {
      // Show loading indicator
      _showLoadingDialog();
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.makeUserAdmin(userId);
      
      // Remove loading indicator
      if (mounted) Navigator.pop(context);
      
      // Refresh user list
      await _loadUsers();
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User is now an admin'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Remove loading indicator
      if (mounted) Navigator.pop(context);
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to make user admin: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  
  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: $_errorMessage',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadUsers,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadUsers,
                  child: _users.isEmpty
                      ? const Center(child: Text('No users found'))
                      : ListView.builder(
                          itemCount: _users.length,
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            final isAdmin = user['isAdmin'] ?? false;
                            final isPro = user['tier'] == 'pro';
                            
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: ListTile(
                                title: Text(user['name'] ?? 'Unknown'),
                                subtitle: Text(user['email'] ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isPro)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'PRO',
                                          style: TextStyle(
                                            color: Colors.blue[800],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    if (isAdmin) ...[
                                      if (isPro) const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          'ADMIN',
                                          style: TextStyle(
                                            color: Colors.red[800],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(width: 8),
                                    IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      onPressed: () => _showUserActionMenu(context, user),
                                    ),
                                  ],
                                ),
                                onTap: () => _showUserActionMenu(context, user),
                              ),
                            );
                          },
                        ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadUsers,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}