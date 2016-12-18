/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

/*!
 * \addtogroup LINKCPP CPP Wrappers
 * @{
 *
 * \ingroup USBLINK
 *
 */

/*! \file
 * \brief USB Link Protocol Header File
 *
 */

#ifndef LINK_H
#define LINK_H

#include <mcu/mcu.h>
#include "iface/dev/sys.h"
#include <string>
#include <vector>

using namespace std;

/*! \brief Class to access Stratify OS from a desktop C++ application
 * \details This class is used to access devices
 * running Stratify OS from a desktop C++ application.
 *
 */
class Link {
public:
    Link();
    ~Link();

    typedef bool (*update_callback_t)(void*, int, int);

    /*! \details This function creates a list of serial numbers of
     * all the devices that are attached to the host.
     */
    static vector<string> get_device_list(link_transport_mdriver_t * d, int max = 64);

    /*! \details This gets the error message if an
     * operation fails.
     */
    string error_message() const { return m_error_message; }

    /*! \details This gets the current progress of an operation.  This allows
     * multi-threaded applications to update a progress bar while copying files.
     */
    int progress() const { return m_progress; }

    /*! \details This gets the maximum progress value of the current operation.
     *
     */
    int progress_max() const { return m_progress_max; }

    /*! \details This gets the status of the current operation in progress.
     *
     */
    string status_message() const { return m_status_message; }

    /*! \details This connects to the specified Stratify OS device.  After calling this,
     * other applications will not have access to the device.
     *
     */
    int init(string path /*! The path to the serial device */,
    		string sn /*! The serial number or an empty string to ignore */,
			string notify_path /*! The path to the notify device */);
    int reinit(){ return init(path(), serial_no(), notify_path()); }

    /*! \details This disconnects from the device.  After calling this,
     * other applications can access the device.
     */
    int exit();

    /*! \details This checks to see if the device is connected.
     * \return true if connected
     */
    bool get_is_connected();

    //These are all the file transfer options over Stratify OS Link

    //Operations on the device
    /*! \details This creates a directory on the target device.
     *
     */
    int mkdir(string directory /*! The directory name */,
    		link_mode_t mode /*! The access permissions */);

    /*! \details This removes a directory on the target device.
     *
     */
    int rmdir(string directory /*! The directory name (must be empty) */); //Directory must be empty

    /*! \details This deletes a file on the target device.
     *
     */
    int unlink(string filename /*! The filename to delete */);

    /*! \details This creates a symbolic link on the device.
     * \note Stratify OS does not currently support symbolic links.  This function will
     * always return an error.
     *
     * \return Zero on sucess.
     */
    int symlink(string oldPath /*! The existing path */,
    		string newPath /*! The path to the new link */);

    /*! \details Load the entries of a directory. */
    vector<string> get_dir_list(string directory);

    /*! \details This methods converts the permissions to a
     * string of the format:
     *
     * -rwxrwxrwx
     *
     * The first character indicates:
     * - - File
     * - d Directory
     * - c Character file
     * - b Block file
     *
     * The order is other, group, user.  If the permission
     * is not available, the character is replace by a "-".
     *
     */
    static string convert_permissions(link_mode_t mode);

    /*! \details This function opens a directory such that it's contents can be
     * read with readdir().
     */
    int opendir(string directory /*! The directory to open */);

    /*! \details This function reads an entry from an open directory.
     *
     * \return The name of the next entry in the directory.
     */
    int readdir_r(int dirp /*! The directory to read (returned from opendir()) */,
    		struct link_dirent * entry /*! A pointer to the destination memory */,
    		struct link_dirent ** result /*! Assigned to \a entry on success or NULL on failure */);

    /*! \details This closes an open directory.
     *
     */
    int closedir(int dirp /*! The directory to close */);

    /*! \details This copies a file either from the device to the
     * host or from the host to the device depending on the value of \a toDevice.
     *
     * \return Zero on success
     */
    int copy(string src /*! The path to the source file */,
    		string dest /*! The path to the destination file */,
    		link_mode_t mode /*! The access permissions if copying to the device */,
    		bool to_device = true /*! When true, copy is from host to device */,
    		bool (*update)(void *, int, int) = 0,
			void * context = 0);

    int copy_file_to_device(string src, string dest, link_mode_t mode, bool (*update)(void*,int,int) = 0, void * context = 0){
    	return copy(src, dest, mode, true, update, context);
    }

    int copy_file_from_device(string src, string dest, link_mode_t mode, bool (*update)(void*,int,int) = 0, void * context = 0){
    	return copy(src, dest, mode, false, update, context);
    }

    /*! \details This formats the filesystem on the device.
     *
     * \return Zero on success
     */
    int format(string path); //Format the drive

    /*! \details This runs an application on the device.
     *
     * \return The PID of the new process or less than zero for an error
     */
    int run_app(string path);


    /*! \details This opens a file (or device such as /dev/adc0) on the target device.
     *
     * \return The file descriptor on success or -1 on failure
     */
    int open(string file /*! The name of the file to open */,
    		int flags /*! The access flags such as LINK_O_RDWR */,
    		link_mode_t mode = 0 /*! The access permissions when creating a new file */);

    /*! \details This reads an open file descriptor.
     *
     * \return Number of bytes read or less than zero on failure
     */
    int read(int fd, void * buf, int nbyte);

    /*! \details This write an open file descriptor.
     *
     * \return Number of bytes written or less than zero on failure
     */
    int write(int fd, const void * buf, int nbyte);

    /*! \details This checks to see if the target is in bootloader mode.
     * \return Non zero if bootloader mode is active.
     */
    bool is_bootloader() const { return m_boot; }


    /*! \details This reads the flash memory of the device.
     * \return Number of bytes read.
     */
    int read_flash(int addr, void * buf, int nbyte);

    /*! \details This writes the flash memory of the device.
     * \return Number of bytes read.
     */
    int write_flash(int addr, const void * buf, int nbyte);

    /*! \details This performs IO ctl on an open file descriptor.  \a fd
     * must refer to a device rather than a regular file.  \a ctl must
     * be unionized with a link_bulk_t, for example:
     * \code
     * union {
     * 	adc_attr_t attr;
     * 	link_bulk_t buf;
     * } adc;
     * adc.attr.freq = 200000;
     * adc.attr.enabled_channels = 0x0F;
     * adc.attr.pin_assign = 0;
     * dev.ioctl(fd, I_SETATTR, &adc);
     * \endcode
     *
     * \return Number of bytes read or less than zero on failure
     */
    int ioctl(int fd, int request, void * ctl = NULL);

    /*! \details This function performs an lseek \a fd.
     *
     * \return Zero on success
     */
    int lseek(int fd, int offset, int whence);

    /*! \details This function reads the file statistics on
     * the specified target device file.
     *
     * \return Zero on success with \a st populated or less than zero on failure
     */
    int stat(string path /*! The path to the target device file */,
    		struct link_stat * st /*! A pointer to the destination structure */);
    int close(int fd);

    /*! \details This function opens the stdio on the device.
     * This is associated with /dev/link-stdio.
     */
    int open_stdio();

    /*! \details This function reads the stdout from the device.
     * This is associated with /dev/link-stdio.
     */
    int read_stdout(void * buf /*! the destination pointer */,
    		int nbyte /*! max bytes to read */,
    		volatile bool * abort /*! if set to true, operation will be aborted */);

    /*! \details This function writes the stdin on the device.
     * This is associated with /dev/link-stdio.
     */
    int write_stdin(const void * buf /*! the data to write */, int nbyte /*! the number of bytes to write */);

    /*! \details This function opens the stdio on the device.
     * This is associated with /dev/link-stdio.
     */
    int close_stdio();

    /*! \details This function kills the process \a pid.
     *
     * \return Zero on success or less than zero on error
     */
    int kill_pid(int pid, int signo);

    /*! \details Get the PID of the specified application name
     *
     * @param name The name of the application to find the pid
     * @return The PID or -1 if the application is not currently running
     */
    int get_pid(string name){ return get_is_executing(name); }

    /*! \details This function resets the device (connection will be terminated)
     *
     * \return Zero on success or less than zero on error
     */
    int reset();

    /*! \details This function resets the device and invokes the DFU bootloader.
     * The connection to the device is terminated with this call.
     *
     * \return Zero on success or less than zero on error
     */
    int reset_bootloader();

    /*! \details This function reads the time from
     * the device.
     *
     * \return Zero on success
     *
     */
    int get_time(struct tm * gt);

    /*! \details This function sets the time on the device.
     * \return Zero on success
     */
    int set_time(struct tm * gt);


    /*! \details This gets the address of the security word on the device.
     * \return Zero on success.
     */
    int get_security_addr(uint32_t * addr);

    /*! \details This renames a file.
     * \return Zero on success
     */
    int rename(string old_path, string new_path);

    /*! \details This changes the ownership of a file.
     * \return Zero on success.
     */
    int chown(string path, int owner, int group);

    /*! \details This changes the mode of a file.
     * \return Zero on success.
     */
    int chmod(string path, int mode);

    /*! \details This method checks to see if a process called \a name is running.
     * \return The pid of the running process or -1 if no processes match the name
     */
    int get_is_executing(string name);

    int update_os(string path, bool verify, bool (*update)(void*,int,int) = 0, void * context = 0);

    link_transport_mdriver_t * driver(){ return m_driver; }
    void set_driver(link_transport_mdriver_t * driver){ m_driver = driver; }

    void set_progress(int p){ m_progress = p; }
    void set_progress_max(int p){ m_progress_max = p; }


    int trace_create(int pid, link_trace_id_t * id);
    int trace_tryget_events(link_trace_id_t id, void * data, size_t num_bytes);
    int trace_shutdown(link_trace_id_t id);

    //creating files in Flash/Ram

    /*! details This method will update a binary app with the specified settings
     *
     * @param path Full path to the binary file
     * @param name The name that should be assigned to the app
     * @param startup True if app should run at startup
     * @param run_in_ram True if app should run in ram
     * @param ram_size Number of bytes the app needs for RAM (excluding code if run_in_ram is true)
     * @return Zero on success or -1 with error() set to an appropriate message
     */
    int update_binary_install_options(string path, string name, bool startup, bool run_in_ram, int ram_size);

    /*! \details This method will install a binary to the specified location
     *
     * @param source The source of the binary file
     * @param dest The location to install the file (directory)
     * @param update A callback to update the caller on the progress of the install
     * @param context First argument passed to \a update
     * @return Zero on success or -1 with error() set to an appropriate message
     */
    int install_app(string source, string dest, string name, bool (*update)(void*,int,int) = 0, void * context = 0);

    /*! \details Return the serial number of the last device
     * that was connected (including the currently connected device)
     * @return A string containing the serial number of the last connected (or currently connected) device
     */
    string serial_no(){ return m_serialno; }

    /*! \details The path of the currently connected (or last connected) device */
    string path(){ return m_path; }

    /*! \details The path of the currently connected (or last connected) notify device */
    string notify_path(){ return m_notify_path; }

    sys_attr_t sys_attr() const { return m_sys_attr; }

    bool is_notify() const { return m_is_notify; }

    int read_notify(void * buf, int nbyte);

private:
    int check_error(int err);
    int lock_device();
    int unlock_device();
    void reset_progress();

    string m_serialno;
    string m_path;
    string m_notify_path;
    string m_error_message;
    string m_status_message;
    int m_stdout_fd;
    int m_stdin_fd;
    volatile int m_progress;
    volatile int m_progress_max;
    volatile int m_lock;
    bool m_boot;
    bool m_is_notify;

    sys_attr_t m_sys_attr;

    link_transport_mdriver_t m_default_driver;
    link_transport_mdriver_t * m_driver;
};

#endif // LINK_H

/*! @} */
