db.group.insertMany([
  {
    'group-id': 'top_admin_group',
    'group-name': 'TOP_ADMIN'
  },
  {
    'group-id': 'admin_group',
    'group-name': 'ADMIN'
  },
  {
    'group-id': 'user_group',
    'group-name': 'USER'
  }
])

db.role.insertMany([
{
    'role-id': 'create_parameter',
    'role-name': 'CREATE_PARAMETER'
  },
{
    'role-id': 'create_rm_tracking',
    'role-name': 'CREATE_RM_TRACKING'
  },
  {
      'role-id': 'create_test_result',
      'role-name': 'CREATE_TEST_RESULT'
    },
{
    'role-id': 'create_rm',
    'role-name': 'CREATE_RM'
  },
{
    'role-id': 'create_customer_po',
    'role-name': 'CREATE_CUSTOMER_PO'
  },
{
    'role-id': 'create_so_number',
    'role-name': 'CREATE_SO_NUMBER'
  },
{
    'role-id': 'create_production_order',
    'role-name': 'CREATE_PRODUCTION_ORDER'
  },
  {
        'role-id': 'get_all_parameter',
        'role-name': 'GET_ALL_PARAMETER'
    },
  {
      'role-id': 'get_all_test_result',
      'role-name': 'GET_ALL_TEST_RESULT'
    },
{
    'role-id': 'get_all_rm',
    'role-name': 'GET_ALL_RM'
  },
  {
      'role-id': 'get_all_rm_tracking',
      'role-name': 'GET_ALL_RM_TRACKING'
  },
{
    'role-id': 'get_all_customer_po',
    'role-name': 'GET_ALL_CUSTOMER_PO'
  },
{
    'role-id': 'get_all_so_number',
    'role-name': 'GET_ALL_SO_NUMBER'
  },
{
    'role-id': 'get_all_production_order',
    'role-name': 'GET_ALL_PRODUCTION_ORDER'
  },
{
    'role-id': 'create_test',
    'role-name': 'CREATE_TEST'
  },
  {
    'role-id': 'get_all_tests',
    'role-name': 'GET_ALL_TESTS'
  },
  {
    'role-id': 'get_tests',
    'role-name': 'GET_TESTS'
  },
  {
    'role-id': 'create_style',
    'role-name': 'CREATE_STYLE'
  },
  {
    'role-id': 'get_all_styles',
    'role-name': 'GET_ALL_STYLES'
  },
  {
    'role-id': 'create_plant',
    'role-name': 'CREATE_PLANT'
  },
  {
      'role-id': 'get_plants',
      'role-name': 'GET_PLANTS'
    },
    {
      'role-id': 'get_all_plants',
      'role-name': 'GET_ALL_PLANTS'
    },
  {
    'role-id': 'create_material',
    'role-name': 'CREATE_MATERIAL'
  },
  {
    'role-id': 'get_all_materials',
    'role-name': 'GET_ALL_MATERIALS'
  },
  {
    'role-id': 'allocate_customer',
    'role-name': 'ALLOCATE_CUSTOMER'
  },
  {
    'role-id': 'update_style',
    'role-name': 'UPDATE_STYLE'
  },
  {
    'role-id': 'allocate_admin',
    'role-name': 'ALLOCATE_ADMIN'
  },
  {
    'role-id': 'login_web',
    'role-name': 'LOGIN_WEB'
  },
  {
    'role-id': 'login_app',
    'role-name': 'LOGIN_APP'
  },
  {
    'role-id': 'create_top_admin',
    'role-name': 'CREATE_TOP_ADMIN'
  },
  {
    'role-id': 'create_admin',
    'role-name': 'CREATE_ADMIN'
  },
  {
    'role-id': 'create_user',
    'role-name': 'CREATE_USER'
  },
  {
    'role-id' : 'create_customer',
    'role-name': 'CREATE_CUSTOMER'
  },
  {
    'role-id' : 'create_plant',
    'role-name': 'CREATE_PLANT'
   },
  {
    'role-id': 'reset_password',
    'role-name': 'RESET_PASSWORD'
  },
  {
    'role-id': 'update_device',
    'role-name': 'UPDATE_DEVICE'
  },
  {
    'role-id': 's_mode_one',
    'role-name': 'SAVE_MODE_ONE'
  },
  {
    'role-id': 's_mode_two',
    'role-name': 'SAVE_MODE_TWO'
  },
  {
    'role-id': 's_mode_three',
    'role-name': 'SAVE_MODE_THREE'
  },
  {
    'role-id': 's_mode_four',
    'role-name': 'SAVE_MODE_FOUR'
  },
  {
    'role-id': 's_mode_five',
    'role-name': 'SAVE_MODE_FIVE'
  },
  {
    'role-id': 's_mode_six',
    'role-name': 'SAVE_MODE_SIX'
  },
  {
    'role-id': 'get_mode_one',
    'role-name': 'GET_MODE_ONE'
  },
  {
    'role-id': 'get_mode_two',
    'role-name': 'GET_MODE_TWO'
  },
  {
    'role-id': 'get_mode_three',
    'role-name': 'GET_MODE_THREE'
  },
  {
    'role-id': 'get_mode_four',
    'role-name': 'GET_MODE_FOUR'
  },
  {
    'role-id': 'get_mode_five',
    'role-name': 'GET_MODE_FIVE'
  },
  {
    'role-id': 'get_mode_six',
    'role-name': 'GET_MODE_SIX'
  },
  {
    'role-id': 'share_report',
    'role-name': 'SHARE_REPORT'
  },
  {
    'role-id': 'get_users',
    'role-name': 'GET_USERS'
  },
  {
    'role-id': 'get_all_customers',
    'role-name': 'GET_ALL_CUSTOMERS'
  },
  {
    'role-id': 'get_all_plants',
    'role-name': 'GET_ALL_PLANTS'
    },
  {
    'role-id': 'update_user',
    'role-name': 'UPDATE_USER'
  },
  {
    'role-id': 'update_admin_user',
    'role-name': 'UPDATE_ADMIN_USER'
  },
  {
      'role-id': 'update_customer',
      'role-name': 'UPDATE_CUSTOMER'
    },
  {
    'role-id': 'get_all_users',
    'role-name': 'GET_ALL_USERS'
  },
  {
    'role-id': 'get_devices',
    'role-name': 'GET_DEVICES'
  },
  {
      'role-id': 'get_last_mode_one',
      'role-name': 'GET_LAST_MODE_ONE'
  }
 ,
  {
       'role-id': 'get_last_mode_two',
       'role-name': 'GET_LAST_MODE_TWO'
  }
  ,
      {
        'role-id': 'get_last_mode_three',
        'role-name': 'GET_LAST_MODE_THREE'
      }
  ,
      {
        'role-id': 'get_last_mode_four',
        'role-name': 'GET_LAST_MODE_FOUR'
      }
  ,
      {
        'role-id': 'get_last_mode_five',
        'role-name': 'GET_LAST_MODE_FIVE'
      }
  ,
      {
        'role-id': 'get_last_mode_six',
        'role-name': 'GET_LAST_MODE_SIX'
      }
])

db.groupRole.insertMany([
{
    'group-id': 'top_admin_group',
    'role-ids': [ 'login_web',
    'login_app',
    'create_top_admin',
    'create_user',
    'create_customer',
    'create_plant',
    'create_material',
    'create_style',
    'create_test',
    'update_admin_user',
    'get_all_parameter',
    'get_all_plants',
    'get_all_users',
    'get_all_customers',
    'get_all_tests',
    'get_all_styles',
    'get_all_materials',
    'get_mode_one',
    'get_mode_two',
    'get_mode_three',
    'get_mode_four',
    'get_mode_five',
    'get_mode_six',
    'create_admin',
    'update_customer',
    'update_style',
    'reset_password',
    'update_device',
    'allocate_admin',
    'allocate_customer',
    'get_devices']
  },
{
    'group-id': 'admin_group',
    'role-ids': [ 'login_web',
    'login_app',
    'create_material',
    'create_parameter',
    'create_test_result',
    'create_rm_tracking',
    'create_rm',
    'create_customer_po',
    'create_so_number',
    'create_production_order',
    'create_user',
    'create_test',
    'reset_password',
    'get_all_parameter',
    'get_all_test_result',
    'get_all_rm_tracking',
    'get_all_rm',
    'get_all_customer_po',
    'get_all_so_number',
    'get_all_production_order',
    'get_tests',
    'get_all_materials',
    's_mode_one',
    's_mode_two',
    's_mode_three',
    's_mode_four',
    's_mode_five',
    's_mode_six',
    'get_mode_one',
    'get_mode_two',
    'get_mode_three',
    'get_mode_four',
    'get_mode_five',
    'get_mode_six',
    'share_report',
    'get_users',
    'update_user',
    'get_devices']
  },
  {
    'group-id': 'user_group',
    'role-ids': [ 'login_app',
    's_mode_one',
    's_mode_two',
    's_mode_three',
    's_mode_four',
    's_mode_five',
    's_mode_six',
    'get_last_mode_one',
    'get_last_mode_two',
    'get_last_mode_three',
    'get_last_mode_four',
    'get_last_mode_five',
    'get_last_mode_six']
  }
])